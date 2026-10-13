

document.addEventListener("DOMContentLoaded", function () {

    // Mobile navigation
    const menuToggle = document.getElementById("menuToggle");
    const mainNav = document.getElementById("mainNav");

    if (menuToggle && mainNav) {
        menuToggle.addEventListener("click", function () {
            const isOpen = mainNav.classList.toggle("open");
            menuToggle.setAttribute("aria-expanded", String(isOpen));
        });

        mainNav.querySelectorAll("a").forEach(function (link) {
            link.addEventListener("click", function () {
                mainNav.classList.remove("open");
                menuToggle.setAttribute("aria-expanded", "false");
            });
        });
    }

    // Business listing elements
    const cards = Array.from(
        document.querySelectorAll(".business-card")
    );

    const searchForm = document.getElementById("searchForm");
    const keywordInput = document.getElementById("keywordInput");
    const locationInput = document.getElementById("locationInput");
    const noResults = document.getElementById("noResults");
    const searchStatus = document.getElementById("searchStatus");

    // Filter businesses by keyword, location and category
    function filterBusinesses(keyword, location, category) {
        const key = (keyword || "").trim().toLowerCase();
        const place = (location || "").trim().toLowerCase();

        let visibleCount = 0;

        cards.forEach(function (card) {
            const searchText = (
                (card.dataset.search || "") + " " + card.innerText
            ).toLowerCase();

            const cardLocation = (
                card.dataset.location || ""
            ).toLowerCase();

            const cardCategory = card.dataset.category || "";

            const matchesKeyword =
                key === "" || searchText.includes(key);

            const matchesLocation =
                place === "" ||
                cardLocation.includes(place) ||
                searchText.includes(place);

            const matchesCategory =
                !category || cardCategory === category;

            const show =
                matchesKeyword &&
                matchesLocation &&
                matchesCategory;

            card.classList.toggle("hidden", !show);
            card.hidden = !show;

            if (show) {
                visibleCount++;
            }
        });

        if (noResults) {
            noResults.hidden = visibleCount !== 0;
        }

        if (searchStatus) {
            if (visibleCount > 0) {
                searchStatus.textContent =
                    visibleCount + " approved listing" +
                    (visibleCount === 1 ? "" : "s") + " found.";
            } else {
                searchStatus.textContent =
                    "No approved listings matched. Try a different search.";
            }
        }

        const businessSection = document.getElementById("businesses");

        if (businessSection) {
            businessSection.scrollIntoView({
                behavior: "smooth",
                block: "start"
            });
        }
    }

    // Search form
    if (searchForm) {
        searchForm.addEventListener("submit", function (event) {
            event.preventDefault();

            filterBusinesses(
                keywordInput ? keywordInput.value : "",
                locationInput ? locationInput.value : "",
                ""
            );
        });
    }

    // Category filter buttons
    document.querySelectorAll(".category-card").forEach(function (button) {
        button.addEventListener("click", function () {
            const category = button.dataset.category || "";

            if (keywordInput) {
                keywordInput.value = "";
            }

            filterBusinesses(
                "",
                locationInput ? locationInput.value : "",
                category
            );
        });
    });

    // Business card links
    document.querySelectorAll(".card-link").forEach(function (link) {
        link.addEventListener("click", function (event) {
            const href = link.getAttribute("href");

            // Allow real navigation when a destination exists.
            if (!href || href === "#") {
                event.preventDefault();
            }
        });
    });

});
