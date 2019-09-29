var currentLatitude = null
var currentLongitude = null
var currentUserAgent = null
var findLocationLoader = document.getElementById("find-location-loader")
var findLocationButton = document.getElementById("find-location-button");
var currentLocationDiv = document.getElementById("current-location")
var currentDeviceDiv = document.getElementById("current-device")
var currentLatDiv = document.getElementById("current-lat")
var currentLngDiv = document.getElementById("current-lng")
var populateLocationButtonDiv = document.getElementById("populate-location-button-container");
var populateLocationButton = document.getElementById("populate-location-button");
var clearLocationButton = document.getElementById("clear-location-button");
var mapImg = document.getElementById("map")

if (findLocationButton) {
  findLocationButton.onclick = function getLocation() {
    if (navigator.geolocation) {
      findLocationLoader.hidden = false
      console.log("Geolocation is supported.");
      var options = {
        enableHighAccuracy: true,
        timeout: 5000,
        maximumAge: 0
      }
      navigator.geolocation.getCurrentPosition(geoSuccess, geoError, options);
    } else { 
      console.log("Geolocation is not supported by this browser.");
    }
  }
}

function generateMapImage(lat, lng) {
  var currentLocation = lat + "," + lng
  var markers = "&markers=" + currentLocation
  var center = "&center=" + currentLocation
  var mapSrc = mapImg.getAttribute("src")
  mapSrcLocation = mapSrc + markers + center
  mapImg.setAttribute("src", mapSrcLocation)
}

function geoSuccess(position) {
  console.log("Geolocation successful!successful!")
  startPos = position;
  currentUserAgent = navigator.userAgent;
  currentLatitude = startPos.coords.latitude;
  currentLongitude = startPos.coords.longitude;
  if (currentLatDiv && currentLngDiv) {
    currentDeviceDiv.innerHTML = currentUserAgent
    currentLatDiv.innerHTML = currentLatitude
    currentLngDiv.innerHTML = currentLongitude
    generateMapImage(currentLatitude, currentLongitude)
    findLocationLoader.hidden = true
    populateLocationButtonDiv.hidden = false
    currentLocationDiv.hidden = false
  }
}

function geoError(error) {
  console.log("Geolocation error!")
  switch(error.code) {
    case error.PERMISSION_DENIED:
      console.log("User denied the request for Geolocation.")
      break;
    case error.POSITION_UNAVAILABLE:
      console.log("Location information is unavailable.")
      break;
    case error.TIMEOUT:
      console.log("The request to get user location timed out.")
      break;
    case error.UNKNOWN_ERROR:
      console.log("An unknown error occurred.")
      break;
  }
}

if (populateLocationButton) {
  populateLocationButton.onclick = function populateLocation() {
    document.getElementById('geo_tag_device_info').value = currentUserAgent;
    document.getElementById('geo_tag_lat').value = currentLatitude;
    document.getElementById('geo_tag_lng').value = currentLongitude;
  }
}

if (clearLocationButton) {
  clearLocationButton.onclick = function populateLocation() {
    document.getElementById('geo_tag_device_info').value = null;
    document.getElementById('geo_tag_lat').value = null;
    document.getElementById('geo_tag_lng').value = null;
  }
}
