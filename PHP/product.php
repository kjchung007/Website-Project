<?php
require_once 'connect.php';

function getProducts() {
    global $conn;
    $sql = "SELECT * FROM products ORDER BY id";
    $result = $conn->query($sql);
    return $result->fetch_all(MYSQLI_ASSOC);
}

$products = getProducts();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Manages Product</title>
    <link rel="stylesheet" href="../CSS/product.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>
<body>
    <nav>
        <img src="../Image/KopiPapa Logo.png" alt="Kopi Papa Logo" class="logo">
        <div class="nav-links">
            <a href="../html/admindashboard.html">HOME</a>
            <a href="product.php">PRODUCT</a>
            <div class="records-container">
                <a href="../html/records.html" class="records-link">RECORDS ▼</a>
                <ul class="dropdown">
                    <li><a href="../html/salesdetails.html">SALES DETAILS</a></li>
                    <li><a href="../html/transaction.html">TRANSACTION REPORT</a></li>
                </ul>
            </div>
            <a href="../html/accounts.html">ACCOUNTS</a>
            <a href="../PHP/profile.php"><i class="fa-solid fa-user"></i></a>
        </div>
    </nav>

    <div class="profile-header">
        <h1>PRODUCT</h1>
    </div>

    <div class="menu-tabs">
        <a href="#" class="menu-tab active" data-category="Drinks">DRINKS</a>
        <span class="divider">|</span>
        <a href="#" class="menu-tab" data-category="Food">FOOD</a>
    </div>

    <div class="drinks-grid">
        <?php foreach ($products as $product): ?>
            <div class="drink-item" data-category="<?php echo htmlspecialchars($product['category']); ?>">
                <img src="../Image/<?php echo htmlspecialchars($product['image']); ?>" alt="<?php echo htmlspecialchars($product['name']); ?>">
                <h1><?php echo htmlspecialchars($product['name']); ?></h1>
                <div class="price-container">
                    <p>RM <?php echo number_format($product['price'], 2); ?></p>
                    <i class="fa-solid fa-sliders" onclick="openModal(this)"></i>
                </div>
            </div>
        <?php endforeach; ?>

        <div class="add-product" data-category="Drinks">
            <span class="add-product-icon">+</span>
        </div>
        <div class="add-product" data-category="Food" style="display: none;">
            <span class="add-product-icon">+</span>
        </div>
    </div>

    <!-- Modal -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <span class="close-btn" onclick="closeModal()">&times;</span>
            </div>
            <div class="modal-body">
                <div class="product-preview">
                    <img id="modalProductImage" src="" alt="Product Image">
                    <h2 id="modalProductName"></h2>
                    <p id="modalProductPrice"></p>
                </div>
                <form id="editProductForm">
                    <div class="form-group">
                        <label>PRODUCT NAME</label>
                        <input type="text" id="productName" name="productName" required>
                    </div>
                    <div class="form-group">
                        <label>PRICE</label>
                        <div class="price-input">
                            <span>RM</span>
                            <input type="number" id="productPrice" name="productPrice" step="0.10" required>
                        </div>
                    </div>
                    <div class="form-actions">
                        <i class="fa-solid fa-trash delete-btn" onclick="deleteProduct(this)"></i>
                        <button type="submit" class="save-btn">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>


    <div id="addProductModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Add New Product</h2>
                <span class="close-btn" onclick="closeAddModal()">&times;</span>
            </div>
            <div class="modal-body">
                <form id="addProductForm">
                    <div class="form-group">
                        <label>PRODUCT NAME</label>
                        <input type="text" id="newProductName" required>
                    </div>
                    <div class="form-group">
                        <label>PRICE</label>
                        <div class="price-input">
                            <span>RM</span>
                            <input type="number" id="newProductPrice" step="0.10" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>CATEGORY</label>
                        <select id="newProductCategory" required>
                            <option value="Drinks">Drinks</option>
                            <option value="Food">Food</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>IMAGE</label>
                        <input type="file" id="newProductImage" accept="image/*" required>
                    </div>
                    <div class="modal-actions">
                        <button type="submit" class="save-btn">Add Product</button>
                        <button type="button" id="cancelAddProduct" class="cancel-btn">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <footer class="footer">
        <div class="container">
            <p>Copyright &copy; 2023 Kopi Papa. All rights reserved.</p>
            <div class="social-icons">
                <a href="https://www.facebook.com/profile.php?id=61556348262104" target="_blank"><i class="fab fa-facebook"></i></a>
                <a href="https://www.instagram.com/kopipapahq/?hl=en" target="_blank"><i class="fab fa-instagram"></i></a>
                <a href="https://www.tiktok.com/@kopi.papa.hq" target="_blank"><i class="fab fa-tiktok"></i></a>
            </div>
        </div>
    </footer>

    <script src="../Javascript/product.js"></script>
</body>
</html>
<?php $conn->close(); ?>