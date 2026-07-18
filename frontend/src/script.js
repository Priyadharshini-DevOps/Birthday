async function loadWish() {

    const response = await fetch("/api/birthday");

    const data = await response.json();

    document.getElementById("name").innerHTML =
        data.name;

    document.getElementById("message").innerHTML =
        data.message;

}