const BASE = '../Php';

const countryCoordinates = {
    "Pakistan": { lat: 30.3753, lng: 69.3451 },
    "Turkey": { lat: 38.9637, lng: 35.2433 },
    "USA": { lat: 37.0902, lng: -95.7129 },
    "Japan": { lat: 36.2048, lng: 138.2529 },
    "China": { lat: 35.8617, lng: 104.1954 },
    "Brazil": { lat: -14.2350, lng: -51.9253 },
    "Australia": { lat: -25.2744, lng: 133.7751 }
};

document.addEventListener("DOMContentLoaded", () => {
    const GlobeConstructor = window.Globe || window.GlobeGL;
    if (!GlobeConstructor) return;

    const container = document.getElementById('globeViz');
    if (!container) return;
 //mera GLOBE===================
    const globeInstance = GlobeConstructor()(container)
        .globeImageUrl('https://unpkg.com/three-globe/example/img/earth-blue-marble.jpg')
        .bumpImageUrl('https://unpkg.com/three-globe/example/img/earth-topology.png')
        .backgroundColor('rgba(0,0,0,0)');

    setTimeout(() => {
        globeInstance.width(container.clientWidth);
        globeInstance.height(container.clientHeight);
    }, 100);

    const resizeObserver = new ResizeObserver(entries => {
        for (let entry of entries) {
            globeInstance.width(entry.contentRect.width);
            globeInstance.height(entry.contentRect.height);
        }
    });
    resizeObserver.observe(container);

    globeInstance.controls().autoRotate = true;
    globeInstance.controls().autoRotateSpeed = 0.5; 

    // Load krny k lye countries from DB=======cryinggggggg
    fetch(`${BASE}/phpget_countries.php`)
        .then(r => r.json())
        .then(countries => {
            const select = document.getElementById('countrySelect');
            if (!select) return;
            select.innerHTML = '<option value="">Select Country...</option>';
            
            countries.forEach(c => {
                const opt = document.createElement('option');
                opt.value = c.Country_ID;
                opt.dataset.name = c.Country_Name;
                opt.textContent = c.Country_Name;
                select.appendChild(opt);
            });
        })
        .catch(() => {
            console.warn('Dynamic DB lookup failed. Activating hardcoded backup map options...');
            const select = document.getElementById('countrySelect');
            if (!select) return;

            select.innerHTML = '<option value="">Select Country...</option>';
            Object.keys(countryCoordinates).forEach((countryName, idx) => {
                const opt = document.createElement('option');
                opt.value = idx + 1; // Simulated database mock IDs
                opt.dataset.name = countryName;
                opt.textContent = countryName;
                select.appendChild(opt);
            });
        });

    // Globe me country effects closeup vgera
    window.focusCountry = function(countryName) {
        if (!countryCoordinates[countryName]) return;

        globeInstance.pointOfView(
            {
                lat: countryCoordinates[countryName].lat,
                lng: countryCoordinates[countryName].lng,
                altitude: 1.8
            },
            1500
        );
    };

    // select option k according =change krny k lye to focus globe camera position
    document.getElementById("countrySelect").addEventListener("change", function() {
        const selectedOption = this.options[this.selectedIndex];
        const countryName = selectedOption?.dataset.name;
        if (countryName) {
            window.focusCountry(countryName);
        }
    });

    // ── Submit Search and Redirect (Separate Tab)====
    window.submitCountry = function() {
        const select = document.getElementById('countrySelect');
        const countryId = select.value;
        const countryName = select.options[select.selectedIndex]?.dataset.name || '';

        if (!countryId) {
            alert("Please select a target country from the control panel.");
            return;
        }

        // Opens imagery-page.html in a dusra tab===yahooooo
        window.open(
            `imagery-page.html?country_id=${countryId}&country=${encodeURIComponent(countryName)}`,
            '_blank'
        );
    };
});