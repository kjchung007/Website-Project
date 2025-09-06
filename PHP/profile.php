<?php
    session_start();

    // Check if the user is logged in
    if (!isset($_SESSION['logged_in']) || $_SESSION['logged_in'] !== true) {
        // Redirect to login page if not logged in
        echo "Please login first";
        header("Location: ../html/login.html");
        exit();
    }

    // Fetch user data from session (replace with database call if needed)
    $name = $_SESSION['member_name'] ?? 'Guest'; // Default to 'Guest' if name is missing
    $email = $_SESSION['member_email'] ?? 'guest@example.com'; // Default email
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
        <h1>MY PROFILE</h1>
    </div>

    <div class="profile-container">
        <div style="display: flex;">
            <div class="profile-nav">
                <ul>
                    <li><a href="profile.php" class="active">HOME</a></li>
                    <li><a href="../html/edit.html">EDIT PROFILE</a></li>
                    <li><a href="profile_my_rewards.php">MY REWARDS</a></li>
                    <li><a href="../html/orders.html">ORDERS</a></li>
                    <li><a href="logout.php">LOG OUT</a></li>
                </ul>
            </div>

            <div class="profile-content">
                <div class="profile-info">
                    <div class="profile-avatar"></div>
                    <div>
                        <h2>WELCOME, <?php echo htmlspecialchars($name); ?></h2>
                        <p><?php echo htmlspecialchars($email); ?></p>
                    </div>
                </div>

                <div class="rewards-card" id="rewardsCard">
                    <img src="../Image/3%20layer%20kopi.png" alt="Coffee Reward" class="rewards-image">
                    <div class="rewards-info">
                        <h3>KOPI PAPA REWARDS</h3>
                        <div class="points-display">
                            <span id="currentPoints">0</span> / <span id="targetPoints">100</span> pts
                        </div>
                        <div class="progress-bar">
                            <div class="progress-fill" id="progressFill"></div>
                        </div>
                        <div class="points-progress">
                            <span id="pointsLeft">100</span> points left to get next reward
                        </div>
                    </div>
                </div>

                <div class="vouchers-section">
                    <h3>VOUCHERS</h3>
                    <p>Enter your voucher code below</p>
                    <div class="voucher-form">
                        <input type="text" class="voucher-input" id="voucherInput" placeholder="Enter voucher code">
                        <button class="claim-btn" onclick="claimVoucher()">CLAIM</button>
                    </div>
                    <div id="voucherMessage"></div>
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
