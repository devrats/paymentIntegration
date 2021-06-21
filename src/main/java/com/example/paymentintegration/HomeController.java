/*   Created by IntelliJ IDEA.
 *   Author: Devvrat Sharma (devrats)
 *   Date: 6/20/2021
 *   Time: 11:13 AM
 *   File: HomeController.java
 */

package com.example.paymentintegration;

import com.razorpay.*;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

@Controller
public class HomeController {

    @RequestMapping("/")
    public String home(){
        return "pay";
    }
    @RequestMapping("/pay")
    @ResponseBody
    public String pay(@RequestBody Map<String, Object> data) throws RazorpayException {
        var client = new RazorpayClient("rzp_test_4sgOUR0hFBHwtn","buf7y58LORq7JKsFuExL7xXS");
        JSONObject object = new JSONObject();
        int amount = Integer.parseInt(data.get("amount").toString());
        object.put("amount",amount*100);
        object.put("currency","INR");
        object.put("receipt","txn_1234");
        Order order = client.Orders.create(object);
        System.out.println(order);
        return order.toString();
    }
}