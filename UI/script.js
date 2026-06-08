const BASE = "../Php";

const countryCoordinates = {
    Pakistan: { lat: 30.3753, lng: 69.3451 },
    Turkey: { lat: 38.9637, lng: 35.2433 },
    USA: { lat: 37.0902, lng: -95.7129 },
    Japan: { lat: 36.2048, lng: 138.2529 },
    China: { lat: 35.8617, lng: 104.1954 },
    Brazil: { lat: -14.2350, lng: -51.9253 },
    Australia: { lat: -25.2744, lng: 133.7751 }
};

let globeInstance = null;

document.addEventListener("DOMContentLoaded", () => {

    // ==========================
    // LOAD COUNTRIES FROM DB
    // ==========================
    fetch(`${BASE}/phpget_countries.php`)
        .then(response => response.json())
        .then(countries => {

            const select = document.getElementById("countrySelect");

            countries.forEach(country => {

                const option = document.createElement("option");

                option.value = country.Country_ID;
                option.textContent = country.Country_Name;
                option.dataset.name = country.Country_Name;

                select.appendChild(option);
            });

        })
        .catch(error => {
            console.error("Country loading failed:", error);
        });

    // ==========================
    // CREATE GLOBE
    // ==========================

    const globeContainer = document.getElementById("globeViz");

    globeInstance = Globe()(globeContainer)
        .globeImageUrl(
            "https://unpkg.com/three-globe/example/img/earth-night.jpg"
        )
        .backgroundImageUrl(
            "https://unpkg.com/three-globe/example/img/night-sky.png"
        );

    globeInstance.width(globeContainer.clientWidth);
    globeInstance.height(globeContainer.clientHeight);

    globeInstance.controls().autoRotate = true;
    globeInstance.controls().autoRotateSpeed = 0.6;
    globeInstance.controls().enableZoom = true;

    // ==========================
    // RESIZE SUPPORT
    // ==========================

    window.addEventListener("resize", () => {

        globeInstance.width(globeContainer.clientWidth);
        globeInstance.height(globeContainer.clientHeight);

    });

    // ==========================
    // COUNTRY CHANGE EVENT
    // ==========================

    document
        .getElementById("countrySelect")
        .addEventListener("change", function () {

            const selectedOption =
                this.options[this.selectedIndex];

            const countryName =
                selectedOption.dataset.name;

            focusCountry(countryName);

        });

});


// =================================
// MOVE GLOBE TO SELECTED COUNTRY
// =================================

function focusCountry(countryName) {

    if (!countryCoordinates[countryName]) return;

    globeInstance.pointOfView(
        {
            lat: countryCoordinates[countryName].lat,
            lng: countryCoordinates[countryName].lng,
            altitude: 1.8
        },
        1500
    );
}


// =================================
// OPEN IMAGERY PAGE
// =================================

function openGallery() {

    const select =
        document.getElementById("countrySelect");

    const countryId = select.value;

    const countryName =
        select.options[select.selectedIndex]
        ?.dataset.name || "";

    if (!countryId) {

        alert("Please select a country first.");

        return;
    }

    window.open(
        `imagery-page.html?country_id=${countryId}&country=${encodeURIComponent(countryName)}`,
        "_blank"
    );
}