USE MobileToyStore;

SELECT receivedDate, userID, productID, orderItemID FROM OrderItem, `Order` WHERE `Order`.orderID = OrderItem.orderID 
AND `Order`.status = 2;
