<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MegaCity Car Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }

                body {
                    font-family: Arial, sans-serif;
                    background-color: #2c2b2b;
                }

                .dashboard{
                    display: flex;
                    justify-content: center;

                }

                .sidebar {
                    height: 100vh;
                    width: 300px;
                    background-color: #2c2b2b;
                    color: white;
                    display: flex;
                    flex-direction: column;
                    justify-content: space-between;
                }

                /* Logo Styles */
                .logo {
                    display: flex;
                    align-items: center;
                    gap: 10px;
                    padding: 10px 25px;
                  }

                  .logo-icon {
                    width: 40px;
                    height: 40px;
                  }

                  .logo-link{
                    text-decoration: none;
                    cursor: pointer;
                    color: #ff4d4d;
                    text-shadow: 4px 4px 8px rgba(0, 0, 0, 0.5);
                    font-size: 24px;
                    font-weight: bold;
                    font-family: cursive;
                    font-style: italic;
                    text-transform: uppercase;
                  }

                /* Menu Styles */
                .menu {
                    margin-top: 30px;
                }

                .menu ul {
                    list-style: none;
                }

                .menu-item {
                    padding: 15px 20px;
                    cursor: pointer;
                    display: flex;
                    align-items: center;
                    transition: background-color 0.3s ease;
                    font-size: 1.1rem;
                }

                .menu-item:hover, .menu-item.active {
                    background-color: rgb(65, 64, 64);
                }

                .menu-item a {
                    color: white;
                    text-decoration: none;
                    display: flex;
                    align-items: center;
                    width: 100%;
                }

                .submenu {
                        list-style-type: none;
                        padding-left: 20px;
                        display: none;
                }

                .menu-item:hover + .submenu,
                .submenu:hover {
                    display: block;
                }

                .icon {
                    margin-right: 15px;
                    font-size: 1.2rem;
                }

                /* Logout Button */
                .logout {
                    padding: 15px 20px;
                    cursor: pointer;
                    display: flex;
                    align-items: center;
                    border-top: 1px solid rgba(255, 255, 255, 0.2);
                    transition: background-color 0.3s ease;
                }

                .logout:hover {
                    background-color: rgb(65, 64, 64);
                }




                .rightside{
                    background-image: url(https://img.freepik.com/premium-vector/abstract-wireframe-technology-background-presentation-banner-cover_654662-5665.jpg);
                    background-size: cover;
                    width: 100%;
                    min-height: 700px;
                    border-top-left-radius: 20px;
                    border-bottom-left-radius: 20px;
                    box-shadow: 3px 0 10px rgba(0, 0, 0, 0.2);
                    padding: 20px;
                }
        .car-card {
            margin-bottom: 20px;
            transition: transform 0.3s;
        }
        .car-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .card-img-top {
            height: 200px;
            object-fit: cover;
        }
        .features-list {
            max-height: 100px;
            overflow-y: auto;
        }
        .modal-dialog {
            max-width: 700px;
        }
        .header-logo {
            height: 50px;
            margin-right: 10px;
        }
        #carForm {
            padding: 20px;
        }
    </style>
</head>
<body>
<div class="dashboard">
<div class="sidebar">
            <!-- Logo Section -->
            <div class="logo">
                <img src="${pageContext.request.contextPath}/images/logo.png"  class="logo-icon">
                <a href="${pageContext.request.contextPath}/dashboard" class="logo-link">Mega City Cab</a>
            </div>

            <!-- Navigation Menu -->
            <nav class="menu">
                <ul>
                    <li class="menu-item">
                        <a href="${pageContext.request.contextPath}/dashboard">
                            <span class="icon">🏠</span> Dashboard
                        </a>
                    </li>
                    <li class="menu-item active">
                        <a href="${pageContext.request.contextPath}/carDetails">
                            <span class="icon">📅</span> Car Availability
                        </a>
                    </li>
                    <li class="menu-item">
                        <a href="${pageContext.request.contextPath}/booking-confirmation">
                            <span class="icon">📖</span> Bookings
                        </a>
                    </li>

                    <!-- Pages Section with Toggle -->
                    <li class="menu-item" onclick="toggleSubmenu()">
                        <span class="icon">📄</span> Pages ▼
                    </li>
                    <ul class="submenu" id="pagesSubmenu">
                        <li class="menu-item">
                            <a href="${pageContext.request.contextPath}/carDetails">Cars</a>
                        </li>
                        <li class="menu-item">
                            <a href="${pageContext.request.contextPath}/DriverDetails">Driver Details</a>
                        </li>
                        <li class="menu-item">
                            <a href="${pageContext.request.contextPath}/DriverAvailability">Driver Availability</a>
                        </li>
                        <li class="menu-item">
                            <a href="${pageContext.request.contextPath}/Aboutpage">About</a>
                        </li>
                        <li class="menu-item">
                            <a href="${pageContext.request.contextPath}/Contactpage">Contact</a>
                        </li>
                        <li class="menu-item">
                            <a href="${pageContext.request.contextPath}/Homecarousel">Home Carousel</a>
                        </li>
                    </ul>

                    <li class="menu-item">
                        <a href="${pageContext.request.contextPath}/UserDetails">
                            <span class="icon">👤</span> Users
                        </a>
                    </li>

                    <li class="menu-item">
                        <a href="${pageContext.request.contextPath}/Messages">
                            <span class="icon">💬</span> Feedback & Messages
                        </a>
                    </li>
                </ul>
            </nav>

            <!-- Logout Button -->
            <div class="logout" onclick="location.href='${pageContext.request.contextPath}/logout'">
                <span class="icon">🚪</span> Logout
            </div>
        </div>

        <div class="rightside">
            <div class="container">
                    <header class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom">
                        <div class="d-flex align-items-center">
                            <h1 class="h3">MegaCity Car Management</h1>
                        </div>
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCarModal">
                            Add New Car
                        </button>
                    </header>

                    <!-- Alert Messages -->
                    <div id="alertContainer"></div>

                    <!-- Car Cards Display -->
                    <div class="row" id="carsContainer">
                        <c:choose>
                            <c:when test="${empty cars}">
                                <div class="col-12 text-center py-5">
                                    <p class="text-muted">No cars available. Add a new car to get started.</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${cars}" var="car">
                                    <div class="col-md-4 mb-4">
                                        <div class="card car-card h-100">
                                            <c:choose>
                                                <c:when test="${not empty car.images}">
                                                    <img src="${pageContext.request.contextPath}/images/${car.images}" class="card-img-top" alt="${car.name}">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="card-img-top bg-secondary d-flex align-items-center justify-content-center">
                                                        <span class="text-white">No Image</span>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                            <div class="card-body">
                                                <h5 class="card-title">${car.name}</h5>
                                                <h6 class="card-subtitle mb-2 text-muted">${car.brand} - ${car.type}</h6>
                                                <p class="card-text">$${car.price}</p>
                                                <div class="d-flex justify-content-between mt-3">
                                                    <button class="btn btn-sm btn-outline-primary edit-car-btn"
                                                            data-car-no="${car.carNo}"
                                                            data-car-name="${car.name}"
                                                            data-car-type="${car.type}"
                                                            data-car-brand="${car.brand}"
                                                            data-car-price="${car.price}"
                                                            data-car-capacity="${car.peopleCapacity}"
                                                            data-car-doors="${car.doors}"
                                                            data-car-fuel="${car.fuelLiters}"
                                                            data-car-about="${car.aboutCar}"
                                                            data-car-included="${car.includedFeatures}"
                                                            data-car-excluded="${car.excludedFeatures}"
                                                            data-car-images="${car.images}">
                                                        Edit
                                                    </button>
                                                    <button class="btn btn-sm btn-outline-danger delete-car-btn" data-car-no="${car.carNo}">Delete</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Add/Edit Car Modal -->
                    <div class="modal fade" id="addCarModal" tabindex="-1" aria-labelledby="addCarModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="addCarModalLabel">Add New Car</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form id="carForm" enctype="multipart/form-data">
                                        <input type="hidden" id="isEdit" name="isEdit" value="false">

                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label for="carNo" class="form-label">Car Number</label>
                                                <input type="text" class="form-control" id="carNo" name="carNo" required>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label for="name" class="form-label">Car Name</label>
                                                <input type="text" class="form-control" id="name" name="name" required>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-4 mb-3">
                                                <label for="type" class="form-label">Type</label>
                                                <input type="text" class="form-control" id="type" name="type" required>
                                            </div>
                                            <div class="col-md-4 mb-3">
                                                <label for="brand" class="form-label">Brand</label>
                                                <input type="text" class="form-control" id="brand" name="brand" required>
                                            </div>
                                            <div class="col-md-4 mb-3">
                                                <label for="price" class="form-label">Price</label>
                                                <input type="number" class="form-control" id="price" name="price" step="0.01" required>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-4 mb-3">
                                                <label for="peopleCapacity" class="form-label">Capacity</label>
                                                <input type="number" class="form-control" id="peopleCapacity" name="peopleCapacity" required>
                                            </div>
                                            <div class="col-md-4 mb-3">
                                                <label for="doors" class="form-label">Doors</label>
                                                <input type="number" class="form-control" id="doors" name="doors" required>
                                            </div>
                                            <div class="col-md-4 mb-3">
                                                <label for="fuelLiters" class="form-label">Fuel Capacity (L)</label>
                                                <input type="number" class="form-control" id="fuelLiters" name="fuelLiters" required>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <label for="aboutCar" class="form-label">About Car</label>
                                            <textarea class="form-control" id="aboutCar" name="aboutCar" rows="3"></textarea>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label for="includedFeatures" class="form-label">Included Features</label>
                                                <textarea class="form-control" id="includedFeatures" name="includedFeatures" rows="3"
                                                    placeholder="Enter features separated by commas"></textarea>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label for="excludedFeatures" class="form-label">Excluded Features</label>
                                                <textarea class="form-control" id="excludedFeatures" name="excludedFeatures" rows="3"
                                                    placeholder="Enter features separated by commas"></textarea>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">Car Image (Max 5MB)</label>
                                            <input type="file" class="form-control" id="image" name="image" accept="image/*">
                                            <div id="currentImage" class="mt-2 d-none">
                                                <p class="mb-2 fw-bold">Current Image:</p>
                                                <div id="imagePreview" class="text-center"></div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                    <button type="button" class="btn btn-primary" id="saveCarBtn">Save Car</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Delete Confirmation Modal -->
                    <div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Confirm Delete</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    Are you sure you want to delete this car? This action cannot be undone.
                                    <p id="deleteCarInfo" class="mt-2 fw-bold"></p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                    <button type="button" class="btn btn-danger" id="confirmDeleteBtn">Delete</button>
                                </div>
                            </div>
                        </div>
                    </div>
        </div>
    </div>





    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function toggleSubmenu() {
            let submenu = document.getElementById("pagesSubmenu");
            submenu.style.display = submenu.style.display === "block" ? "none" : "block";
        }

        document.addEventListener('DOMContentLoaded', function() {
            const carForm = document.getElementById('carForm');
            const saveCarBtn = document.getElementById('saveCarBtn');
            const addCarModal = new bootstrap.Modal(document.getElementById('addCarModal'));
            const deleteConfirmModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
            let currentCarNo = '';

            // Show alert function
            function showAlert(message, type) {
                const alertContainer = document.getElementById('alertContainer');
                const alertDiv = document.createElement('div');
                alertDiv.className = `alert alert-${type} alert-dismissible fade show`;
                alertDiv.innerHTML = `
                    ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                `;
                alertContainer.appendChild(alertDiv);

                // Auto-dismiss after 5 seconds
                setTimeout(() => {
                    alertDiv.classList.remove('show');
                    setTimeout(() => alertDiv.remove(), 150);
                }, 5000);
            }

            // Reset form
            function resetForm() {
                carForm.reset();
                document.getElementById('isEdit').value = 'false';
                document.getElementById('addCarModalLabel').textContent = 'Add New Car';
                document.getElementById('carNo').readOnly = false;
                document.getElementById('currentImage').classList.add('d-none');
                document.getElementById('imagePreview').innerHTML = '';
            }

            // Add Car button click
            document.querySelector('[data-bs-target="#addCarModal"]').addEventListener('click', function() {
                resetForm();
            });

            // Edit Car button click
            document.addEventListener('click', function(e) {
                if (e.target.classList.contains('edit-car-btn')) {
                    resetForm();

                    const carData = e.target.dataset;
                    document.getElementById('isEdit').value = 'true';
                    document.getElementById('addCarModalLabel').textContent = 'Edit Car';

                    // Fill form with car data
                    document.getElementById('carNo').value = carData.carNo;
                    document.getElementById('carNo').readOnly = true;
                    document.getElementById('name').value = carData.carName;
                    document.getElementById('type').value = carData.carType;
                    document.getElementById('brand').value = carData.carBrand;
                    document.getElementById('price').value = carData.carPrice;
                    document.getElementById('peopleCapacity').value = carData.carCapacity;
                    document.getElementById('doors').value = carData.carDoors;
                    document.getElementById('fuelLiters').value = carData.carFuel;
                    document.getElementById('aboutCar').value = carData.carAbout;
                    document.getElementById('includedFeatures').value = carData.carIncluded;
                    document.getElementById('excludedFeatures').value = carData.carExcluded;

                    // Show current image if any
                    if (carData.carImages && carData.carImages.length > 0) {
                        const imagePreview = document.getElementById('imagePreview');
                        imagePreview.innerHTML = `
                            <div class="position-relative">
                                <img src="${pageContext.request.contextPath}/images/${carData.carImages.trim()}" class="img-thumbnail" style="height: 200px; object-fit: cover;" alt="Car Image">
                            </div>
                        `;

                        document.getElementById('currentImage').classList.remove('d-none');
                    }

                    addCarModal.show();
                }
            });

            // Delete Car button click
            document.addEventListener('click', function(e) {
                if (e.target.classList.contains('delete-car-btn')) {
                    const carNo = e.target.getAttribute('data-car-no');
                    if (carNo) {
                        currentCarNo = carNo;
                        const carName = e.target.closest('.card-body').querySelector('.card-title').textContent;
                        document.getElementById('deleteCarInfo').textContent = `Car: ${carName} (${carNo})`;
                        console.log("Car to delete:", currentCarNo);
                        deleteConfirmModal.show();
                    } else {
                        console.error("No car number found on delete button");
                        showAlert("Error: Could not identify car to delete", "danger");
                    }
                }
            });

            // Save Car button click
            saveCarBtn.addEventListener('click', function() {
                const formData = new FormData(carForm);
                const isEdit = document.getElementById('isEdit').value === 'true';

                // Validate required fields
                let isValid = true;
                const requiredFields = ['carNo', 'name', 'type', 'brand', 'price', 'peopleCapacity', 'doors', 'fuelLiters'];

                requiredFields.forEach(field => {
                    const input = document.getElementById(field);
                    if (!input.value.trim()) {
                        input.classList.add('is-invalid');
                        isValid = false;
                    } else {
                        input.classList.remove('is-invalid');
                    }
                });

                if (!isValid) {
                    return;
                }

                // Check file size if file is selected (max 5MB)
                const imageFile = document.getElementById('image').files[0];
                if (imageFile && imageFile.size > 5 * 1024 * 1024) {
                    showAlert('Image file must be less than 5MB', 'danger');
                    return;
                }

                // Submit form
                const carNo = document.getElementById('carNo').value;
                const url = isEdit ? `/api/cars/${carNo}` : '/api/cars';
                const method = isEdit ? 'PUT' : 'POST';

                fetch(url, {
                    method: method,
                    body: formData
                })
                .then(response => {
                    if (!response.ok) {
                        if (response.status === 413) {
                            throw new Error('File too large. Maximum upload size exceeded.');
                        }
                        return response.text().then(text => { throw new Error(text) });
                    }
                    return response.json();
                })
                .then(data => {
                    showAlert(`Car successfully ${isEdit ? 'updated' : 'added'}!`, 'success');
                    addCarModal.hide();
                    // Reload page to show updated car list
                    setTimeout(() => location.reload(), 1000);
                })
                .catch(error => {
                    console.error('Error:', error);
                    showAlert(`Error: ${error.message}`, 'danger');
                });
            });

            // Confirm Delete button click
            document.getElementById('confirmDeleteBtn').addEventListener('click', function() {
                if (!currentCarNo) {
                    console.error("No car number found for deletion");
                    showAlert("Error: No car number specified for deletion", "danger");
                    deleteConfirmModal.hide();
                    return;
                }

                console.log(`Sending DELETE request to: /api/cars/${currentCarNo}`);

                fetch(`/api/cars/${currentCarNo}`, {
                    method: 'DELETE',
                    headers: {
                        'Accept': 'application/json'
                    }
                })
                .then(response => {
                    console.log("Delete response status:", response.status);

                    if (!response.ok) {
                        if (response.status === 404) {
                            throw new Error('Car not found');
                        }
                        return response.text().then(text => {
                            console.error("Error response:", text);
                            throw new Error(text || 'Unknown error occurred');
                        });
                    }
                    showAlert('Car successfully deleted!', 'success');
                    deleteConfirmModal.hide();
                    // Reload page to show updated car list
                    setTimeout(() => location.reload(), 1000);
                })
                .catch(error => {
                    console.error('Delete error:', error);
                    showAlert(`Error: ${error.message}`, 'danger');
                    deleteConfirmModal.hide();
                });
            });
        });
    </script>
</body>
</html>