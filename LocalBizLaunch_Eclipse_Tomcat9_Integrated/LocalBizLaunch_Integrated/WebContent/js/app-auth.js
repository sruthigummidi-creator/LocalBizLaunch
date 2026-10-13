
const params = new URLSearchParams(window.location.search);
const roleSelect = document.getElementById("role");

if (roleSelect && params.get("role") === "OWNER") {
    roleSelect.value = "OWNER";
}

const registerForm = document.getElementById("registerForm");

if (registerForm) {
    registerForm.addEventListener("submit", function (event) {
        const passwordInput = document.getElementById("password");
        const confirmInput = document.getElementById("confirmPassword");
        const message = document.getElementById("formMessage");

        const password = passwordInput ? passwordInput.value : "";
        const confirmPassword = confirmInput ? confirmInput.value : "";

        if (password !== confirmPassword) {
            event.preventDefault();

            if (message) {
                message.classList.remove("success");
                message.textContent =
                    "The passwords do not match. Please check them.";
            }

            if (confirmInput) {
                confirmInput.focus();
            }
        }
    });
}
