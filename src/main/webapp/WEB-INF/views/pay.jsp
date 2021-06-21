<%--
  Created by IntelliJ IDEA.
  User: Sharma Ji
  Date: 6/20/2021
  Time: 11:17 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Pay</title>
</head>
<body>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<input type="text" name="amount" id="payment_field">
<input type="submit" name="submit" onclick="payment()">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
        integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
        crossorigin="anonymous"></script>
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
<script>
    const payment = () => {
        console.log("payment started");
        var amount = $("#payment_field").val();
        console.log(amount);
        $.ajax(
            {
                url: '/pay',
                data: JSON.stringify({amount: amount}),
                contentType: 'application/json',
                type: 'POST',
                dataType: 'json',
                success: function (response) {
                    console.log(response);
                    if (response.status == "created") {
                        var options = {
                            "key": "rzp_test_4sgOUR0hFBHwtn",
                            "amount": response.amount,
                            "currency": "INR",
                            "name": "Devvrat",
                            "description": "paisa laya",
                            "order_id": response.id,
                            "handler": function (response) {
                                //alert(response.razorpay_payment_id);
                                //alert(response.razorpay_order_id);
                                //alert(response.razorpay_signature)
                                swal.fire(
                                    'Good job!',
                                    'payment successful',
                                    'success'
                                )
                            },
                            "prefill": {
                                "name": "",
                                "email": "",
                                "contact": ""
                            },
                            "notes": {
                                "address": "thoda pisa dedo"

                            },
                            "theme": {
                                "color": "#3399cc"
                            }
                        };
                        var rzp1 = new Razorpay(options);
                        rzp1.on('payment.failed', function (response) {
                            alert(response.error.code);
                            alert(response.error.description);
                            alert(response.error.source);
                            alert(response.error.step);
                            alert(response.error.reason);
                            alert(response.error.metadata.order_id);
                            alert(response.error.metadata.payment_id);
                        });
                        rzp1.open();

                    }
                }
            }
        )
    };
</script>
</body>
</html>
