<?php
// Include the database connection file
include '../connection.php';
include '../session_check.php'; 
include '../user_query.php';
?>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Budget Approvals</title>
    <link rel="shortcut icon" type="image/png" href="../assets/images/logos/angat sikat.png" />
    <link rel="stylesheet" href="../assets/css/styles.min.css" />
    <!--Custom CSS for Budget Overview-->
    <link rel="stylesheet" href="../budget_management/css/budget.css" />
    <!--Boxicon-->
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
    <!--Font Awesome-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <!-- Lordicon (for animated icons) -->
    <script src="https://cdn.lordicon.com/lordicon.js"></script>
    <!--Bootstrap Script-->
    <script src="../assets/libs/jquery/dist/jquery.min.js"></script>
    <!-- solar icons -->
    <script src="https://cdn.jsdelivr.net/npm/iconify-icon@1.0.8/dist/iconify-icon.min.js"></script>
    <!-- DataTables JavaScript for table interactions and pagination -->
    <script src="https://cdn.datatables.net/2.1.7/js/dataTables.js"></script>
    <script src="https://cdn.datatables.net/2.1.7/js/dataTables.bootstrap5.js"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/2.1.7/css/dataTables.bootstrap.min.css" />
</head>

<body>
    <!-- Overall Body Wrapper -->
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
        data-sidebar-position="fixed" data-header-position="fixed">
        <?php include '../../navbar.php';?>

            <div class="container mt-4 p-5">
                <h2 class="mb-4"><span class="text-warning fw-bold me-2">|</span> Budget Approvals Archive</h2>

                <!-- Approval Table -->
                <table id="budgetApprovalsArchive" class="table mt-4">
                    <thead>
                        <tr>
                            <th>Title</th>
                            <th>Category</th>
                            <th>Attachment</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                    // Fetch data from budget_approvals table for non-admin users
                    $approvalsQuery = "SELECT * FROM budget_approvals WHERE organization_id = $organization_id AND archived = 1"; // Hardcoded for testing
                    $approvalsResult = mysqli_query($conn, $approvalsQuery);
                    while ($row = mysqli_fetch_assoc($approvalsResult)) {
                        ?>
                        <tr>
                            <td>
                                <?php echo $row['title']; ?>
                            </td>
                            <td>
                                <?php echo ucfirst($row['category']); ?>
                            </td>
                            <td><a href="uploads/<?php echo $row['attachment']; ?>"
                                    class='link-offset-2 link-underline link-underline-opacity-0' target="_blank">
                                    <?php echo $row['attachment']; ?>
                                </a></td>
                            <td>
                                <?php 
                                // Display status but don't allow editing
                                if ($row['status'] == 'Pending') {
                                    echo " <span class='badge rounded-pill pending'> ";
                                } else if ($row['status'] == 'Approved') {
                                    echo " <span class='badge rounded-pill approved'> ";
                                } else if ($row['status'] == 'Disapproved') {
                                    echo " <span class='badge rounded-pill disapproved'> ";
                                }
                                echo ucfirst($row['status']); 
                                ?>
                                </span>
                            </td>
                            <td>
                                <!-- Non-admin users can edit other fields except status -->
                                <button class='btn btn-primary btn-sm recover-btn mb-3' data-bs-toggle='modal'
                                    data-bs-target='#recoverModal'
                                    data-id="<?php echo $row['approval_id']; ?>"><i class='fa-solid fa-hammer'></i> Recover
                                </button>
                                <button class='btn btn-danger btn-sm delete-btn mb-3' data-bs-toggle='modal'
                                    data-bs-target='#deleteModal'
                                    data-id="<?php echo $row['approval_id']; ?>"><i class='fa-solid fa-trash'></i> Delete
                                </button>
                            </td>
                        </tr>
                        <?php
                    }
                    ?>
                    </tbody>
                </table>
            </div>
            <!-- Recover Event Modal -->
            <div class="modal fade" id="recoverModal" tabindex="-1" aria-labelledby="recoverLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Recover Request</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <p>Are you sure you want to recover this request?</p>

                                <!-- Hidden form for item and event IDs -->
                                <form id="recoverForm">
                                    <input type="hidden" name="approval_id" id="recover_approval_id"> <!-- Event ID -->
                                </form>

                                <!-- Success message -->
                                <div id="recoverSuccessMessage" class="alert alert-success d-none"></div>
                                
                                <!-- Error message -->
                                <div id="recoverErrorMessage" class="alert alert-danger d-none">
                                    <ul id="recoverErrorList"></ul>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-danger" id="confirmRecoverBtn">Recover</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Delete Confirmation Modal -->
                <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Delete Request</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <p>Are you sure you want to delete this request?</p>

                                <!-- Hidden form for item and event IDs -->
                                <form id="deleteForm">
                                    <input type="hidden" name="approval_id" id="delete_approval_id"> <!-- Event ID -->
                                </form>

                                <!-- Success message -->
                                <div id="deleteSuccessMessage" class="alert alert-success d-none"></div>
                                
                                <!-- Error message -->
                                <div id="deleteErrorMessage" class="alert alert-danger d-none">
                                    <ul id="deleteErrorList"></ul>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-danger" id="confirmDeleteBtn">Delete</button>
                            </div>
                        </div>
                    </div>
                </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>                                
            <script src="js/budget_approvals_archive.js"></script>
            <script>
                $(document).ready(function () {
                    // Toggle the sidebar using the bars icon
                    $('#sidebarToggle').on('click', function () {
                        $('#sidebar').toggleClass('active');
                        $('#content').toggleClass('active');
                        $(this).toggleClass('active');
                    });
                });
            </script>

        </div>
        <!-- End of 2nd Body Wrapper -->
    </div>
    <!-- End of Overall Body Wrapper -->
</body>

</html>