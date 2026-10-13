
const params = new URLSearchParams(window.location.search);
const roleSelect = document.getElementById("role");

if (roleSelect && params.get("role") === "OWNER") {
    roleSelect.value = "OWNER";
}

const registerForm = document.getElementById("registerForm");

if (registerForm) {
    registerForm.addEventListener("submit", function (event) {
        const password = document.getElementById("password").value;
        const confirmPassword =
            document.getElementById("confirmPassword").value;
        const message = document.getElementById("formMessage");

        if (password !== confirmPassword) {
            event.preventDefault();
            message.textContent =
                "The passwords do not match. Please check them.";
            message.classList.remove("success");
            return;
        }
    });
}

const loginForm = document.getElementById("loginForm");

if (loginForm) {
    loginForm.addEventListener("submit", function (event) {
        const message = document.getElementById("formMessage");

        if (message) {
            message.textContent = "";
        }
    });
}
