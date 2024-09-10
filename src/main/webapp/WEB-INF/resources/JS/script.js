
    function validateForm() {
        let username = document.getElementById("username").value;
        let password = document.getElementById("password").value;
        let errorDiv = document.getElementById("error-message");
        
        errorDiv.innerHTML = "";  // Clear previous errors

        if (username === "") {
            errorDiv.innerHTML = "Username is required.";
            return false;
        }
        if (password === "") {
            errorDiv.innerHTML = "Password is required.";
            return false;
        }
        return true;
    }

