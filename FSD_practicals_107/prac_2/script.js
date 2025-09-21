const apiKey = '9d238441134447f96b290e49aa4b7f57'; // Your OpenWeatherMap API key

const cityInput = document.getElementById('city-input');
const searchBtn = document.getElementById('search-btn');
const cityName = document.getElementById('city-name');
const temperature = document.getElementById('temperature');
const weatherDescription = document.getElementById('weather-description');
const humidity = document.getElementById('humidity');
const windSpeed = document.getElementById('wind-speed');
const weatherIcon = document.getElementById('weather-icon');

// Function to fetch weather data by city name
async function fetchWeatherByCity(city) {
  const apiUrl = `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${apiKey}&units=metric`;
  try {
    const response = await fetch(apiUrl);
    const data = await response.json();
    if (data.cod === 200) {
      updateWeather(data);
    } else {
      alert('City not found. Please enter a valid city name.');
    }
  } catch (error) {
    console.error('Error fetching weather data:', error);
    alert('Unable to fetch data. Check your internet connection or API key.');
  }
}

// Function to fetch weather data by latitude and longitude
async function fetchWeatherByCoords(lat, lon) {
  const apiUrl = `https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${apiKey}&units=metric`;
  try {
    const response = await fetch(apiUrl);
    const data = await response.json();
    if (data.cod === 200) {
      updateWeather(data);
    } else {
      alert('Unable to fetch weather data. Please try again.');
    }
  } catch (error) {
    console.error('Error fetching weather data:', error);
  }
}

// Function to update the UI with weather data
function updateWeather(data) {
  cityName.textContent = data.name;
  temperature.textContent = `${Math.round(data.main.temp)}°C`;
  weatherDescription.textContent = data.weather[0].description;
  humidity.textContent = `Humidity: ${data.main.humidity}%`;
  windSpeed.textContent = `Wind Speed: ${data.wind.speed} m/s`;
  weatherIcon.innerHTML = `<img src="https://openweathermap.org/img/wn/${data.weather[0].icon}@2x.png" alt="${data.weather[0].description}">`;
}

// Function to get the user's current location
function getLocation() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
      (position) => {
        fetchWeatherByCoords(position.coords.latitude, position.coords.longitude);
      },
      () => {
        alert('Location access denied. Please enter a city manually.');
      }
    );
  } else {
    alert('Geolocation is not supported by your browser.');
  }
}

// Event listener for search button
searchBtn.addEventListener('click', () => {
  const city = cityInput.value.trim();
  if (city) {
    fetchWeatherByCity(city);
  } else {
    alert('Please enter a city name.');
  }
});

// Event listener for pressing "Enter" key in the input field
cityInput.addEventListener('keypress', (event) => {
  if (event.key === 'Enter') {
    searchBtn.click();
  }
});

// Fetch weather data when the page loads (geolocation)
window.onload = getLocation;
