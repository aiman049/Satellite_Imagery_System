document.addEventListener("DOMContentLoaded", () => {
    const countries = {
        Pakistan: { lat: 30.3753, lng: 69.3451 },
        Turkey: { lat: 38.9637, lng: 35.2433 },
        USA: { lat: 37.0902, lng: -95.7129 },
        Japan: { lat: 36.2048, lng: 138.2529 },
        China: { lat: 35.8617, lng: 104.1954 },
        Brazil: { lat: -14.2350, lng: -51.9253 },
        Australia: { lat: -25.2744, lng: 133.7751 }
    };

    const GlobeConstructor = window.Globe || window.GlobeGL;
    if (!GlobeConstructor) return;

    const container = document.getElementById('globeViz');
    if (!container) return;

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

    window.focusCountry = function(country) {
        if (!countries[country]) return;

        document.getElementById("countryInput").value = country;

        globeInstance.pointOfView(
            {
                lat: countries[country].lat,
                lng: countries[country].lng,
                altitude: 1.8
            },
            1500
        );
    };

    window.submitCountry = function() {
        const country = document.getElementById("countryInput").value;

        if (country === "") {
            alert("Please select a target country from the control panel.");
            return;
        }

        alert(`Establishing data link... Querying imagery databases for: ${country}`);
    };

    document.getElementById("countryInput").addEventListener("change", function() {
        const country = this.value;
        if (country) {
            window.focusCountry(country);
        }
    });
});