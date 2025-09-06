<?php
    session_start();

    // Check if the user is logged in
    if (!isset($_SESSION['logged_in']) || $_SESSION['logged_in'] !== true) {
        // Redirect to login page if not logged in
        header("Location: ../html/login.html");
        exit();
    }

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Kopi Papa</title>
    <link rel="stylesheet" href="../CSS/profile.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <script src="https://kit.fontawesome.com/your-font-awesome-kit.js" crossorigin="anonymous"></script>

</head>
<body>
    <nav>
    <img src="../Image/KopiPapa Logo.png" alt="Kopi Papa Logo" class="logo">
        <div class="nav-links">
            <a href="../html/home.html">HOME</a>
            <a href="../html/menu.html">MENU</a>
            <a href="../html/reward.html">REWARDS</a>
            <a href="../html/collab.html" class="collab-btn">COLLAB</a>
            <div class="about-us-container">
                <a href="../html/about us.html" class="about-us-link">ABOUT US ▼</a>
                <ul class="dropdown">
                    <li><a href="../html/FAQ.html">FAQ</a></li>
                    <li><a href="../html/feedbackpage.html">FEEDBACK</a></li>
                    <li><a href="../html/charity.html">CHARITY</a></li>
                </ul>
            </div>
            <a href="../html/cart.html">CART</a>
            <a href="../PHP/profile.php"><i class="fa-solid fa-user"></i></a>
        </div>
    </nav>

    <div class="profile-header">
        <h1>MY REWARDS</h1>
    </div>

    <div class="profile-container">
        <div style="display: flex;">
        <div class="profile-nav">
                <ul>
                    <li><a href="../PHP/profile.php" class="active">HOME</a></li>
                    <li><a href="../html/edit.html">EDIT PROFILE</a></li>
                    <li><a href="../PHP/profile_my_rewards.php">MY REWARDS</a></li>
                    <li><a href="../html/orders.html">ORDERS</a></li>
                    <li><a href="logout.php">LOG OUT</a></li>
                </ul>
            </div>

            <!-- Add this div inside your profile-container, after profile-nav -->
        <div class="vouchers-container">
            <div class="voucher-card">
                <div class="voucher-left">
                    <img src="../Image/voucher1.png" alt="Kopi Papa Voucher" class="voucher-thumb">
                </div>
                <div class="voucher-right">
                    <div class="voucher-title">RM 1 OFF VOUCHER</div>
                    <div class="voucher-validity">Valid until 10/11/2024, 12:00PM</div>
                    <div class="status active">ACTIVE</div>
                    <button class="use-now-btn">Use Now</button>
                </div>
            </div>

            <div class="voucher-card">
                <div class="voucher-left">
                    <img src="../Image/voucher2.png" alt="Kopi Papa Voucher" class="voucher-thumb">
                </div>
                <div class="voucher-right">
                    <div class="voucher-title">RM 5 OFF VOUCHER</div>
                    <div class="voucher-validity">Valid until 10/11/2024, 12:00PM</div>
                    <div class="status active">ACTIVE</div>
                    <button class="use-now-btn">Use Now</button>
                </div>
            </div>

            <div class="voucher-card">
                <div class="voucher-left">
                <img src="../Image/voucher3.png" alt="Kopi Papa Voucher" class="voucher-thumb">
                </div>
                <div class="voucher-right">
                    <div class="voucher-title">FREE ANY 1 BEVERAGE VOUCHER</div>
                    <div class="voucher-validity">Used On 31/10/2024, 10:55AM</div>
                    <div class="status past">PAST</div>
                </div>
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

    <script src="../Javascript/registration.js"></script>

</body>
</html>
