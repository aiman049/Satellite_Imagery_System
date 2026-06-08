const BASE = '../Php';

window.addEventListener('DOMContentLoaded', () => {

    // ── Load countries from DB ────────────────────────────────
    fetch(`${BASE}/phpget_countries.php`)
        .then(r => r.json())
        .then(countries => {
            const select = document.getElementById('countrySelect');
            if (!select) return;
            countries.forEach(c => {
                const opt        = document.createElement('option');
                opt.value        = c.Country_ID;
                opt.dataset.name = c.Country_Name;
                opt.textContent  = c.Country_Name;
                select.appendChild(opt);
            });
        })
        .catch(() => {
            console.error('Could not load countries. Make sure XAMPP is running.');
        });

    // ── Init Globe ────────────────────────────────────────────
    const globeContainer = document.getElementById('globeViz');
    if (!globeContainer) return;

    const globe = Globe()
        .globeImageUrl('//unpkg.com/three-globe/example/img/earth-night.jpg')
        .backgroundImageUrl('//unpkg.com/three-globe/example/img/night-sky.png')
        .width(globeContainer.offsetWidth)
        .height(window.innerHeight)(globeContainer);

    globe.controls().autoRotate      = true;
    globe.controls().autoRotateSpeed = 0.6;
    globe.controls().enableZoom      = true;

    window.addEventListener('resize', () => {
        globe.width(globeContainer.offsetWidth);
        globe.height(window.innerHeight);
    });
});

// ── Open imagery page in new tab ──────────────────────────────
function openGallery() {
    const select      = document.getElementById('countrySelect');
    const countryId   = select.value;
    const countryName = select.options[select.selectedIndex]?.dataset.name || '';

    if (!countryId) {
        alert('Please select a country first.');
        return;
    }

    window.open(
        `imagery-page.html?country_id=${countryId}&country=${encodeURIComponent(countryName)}`,
        '_blank'
    );
}