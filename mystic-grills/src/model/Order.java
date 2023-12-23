package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Date;

import database.Connect;

public class Order
{
	private int orderId;
	private int orderUserId;
	private User orderUser;
	private ArrayList<OrderItem> orderItems;
	private String orderStatus;
	private Date orderDate;
	private double orderTotal;
	
	public Order(int orderId, int orderUserId, String orderStatus, Date orderDate)
	{
		super();
		this.orderId = orderId;
		this.orderUserId = orderUserId;
		this.orderStatus = orderStatus;
		this.orderDate = orderDate;
	}
	
	
	// CRUD
	
	public static int createOrder(User orderUser, ArrayList<OrderItem> orderItems, Date orderDate)
	{
		String[] returnId = { "orderId" };
		String query = "INSERT INTO orders (orderId, userId, orderStatus, orderDate) VALUES (? ,? ,? ,? );";
		  
		try (Connection connection = Connect.getInstance().getConnection())
		{
			PreparedStatement prep = connection.prepareStatement(query, returnId);
			prep.setInt   (1, 0);
			prep.setInt	  (2, orderUser.getUserId());
			prep.setString(3, "Pending");
			prep.setDate  (4, orderDate);
			prep.executeUpdate();
			
			ResultSet rs = prep.getGeneratedKeys();
			if(rs.next())
			{
				return rs.getInt(1);
			}
			return 0;
		}
		catch (SQLException e)
		{
			e.printStackTrace();
			return 0;
		}
	}
	
	public static ArrayList<Order> getOrdersByCustomerId(int customerId)
	{
		ArrayList<Order> orders = new ArrayList<Order>();
		String query = "SELECT * FROM orders WHERE userId = ?;";
		  
		try (Connection connection = Connect.getInstance().getConnection())
		{
			PreparedStatement prep = connection.prepareStatement(query);
			prep.setInt   (1, customerId);
			ResultSet resultSet = prep.executeQuery();
			while(resultSet.next())
			{
				int id = resultSet.getInt("orderId");
				int userId = resultSet.getInt("userId");
				String status = resultSet.getString("orderStatus");
				Date date = resultSet.getDate("orderDate");
				orders.add(new Order(id, userId, status, date));
			}
			resultSet.close();
			
			for (Order order : orders)
			{
				order.setOrderUser(User.getUserById(order.getOrderUserId()));
				order.setOrderItems(OrderItem.getAllOrderItemsByOrderId(order.getOrderId()));
				order.setOrderTotal(Order.getTotalByOrderId(order.getOrderId()));
			}
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		return orders;
	}
	
	public static ArrayList<Order> getAllOrders()
	{
		ArrayList<Order> orders = new ArrayList<>();
		String query = "SELECT * FROM orders;";
		
		try (Connection connection = Connect.getInstance().getConnection())
		{
			PreparedStatement prep = connection.prepareStatement(query);
			ResultSet resultSet = prep.executeQuery();
			
			while(resultSet.next()) 
			{
				int id = resultSet.getInt("orderId");
				int userId = resultSet.getInt("userId");
				String status = resultSet.getString("orderStatus");
				Date date = resultSet.getDate("orderDate");
				orders.add(new Order(id, userId, status, date));
			}
			resultSet.close();
			
			for (Order order : orders)
			{
				order.setOrderUser(User.getUserById(order.getOrderUserId()));
				order.setOrderItems(OrderItem.getAllOrderItemsByOrderId(order.getOrderId()));
				order.setOrderTotal(Order.getTotalByOrderId(order.getOrderId()));
			}
		} 
		catch (SQLException e)
		{
			e.printStackTrace();
		} 
		return orders;
	}
	
	public static Order getOrderById(int orderId) 
	{
		Order order = null;
		String query = "SELECT * FROM orders WHERE orderId = ?;";
		
		try (Connection connection = Connect.getInstance().getConnection())
		{
			PreparedStatement prep = connection.prepareStatement(query);
			prep.setInt(1, orderId);
			ResultSet resultSet = prep.executeQuery();

			if(resultSet.next())
			{
				int orderUserId = resultSet.getInt("userId");
				String orderStatus = resultSet.getString("orderStatus");
				Date orderDate = resultSet.getDate("orderDate");
				order = new Order(orderId, orderUserId, orderStatus, orderDate);
			}
			resultSet.close();
			order.setOrderUser(User.getUserById(order.getOrderUserId()));
			order.setOrderItems(OrderItem.getAllOrderItemsByOrderId(order.getOrderId()));
			order.setOrderTotal(Order.getTotalByOrderId(order.getOrderId()));
		} 
		catch (SQLException e)
		{
			e.printStackTrace();
		} 
		return order;
	}
	
	public static String updateOrder(int orderId, ArrayList<OrderItem> orderItems, String orderStatus)
	{
//		String deleteOrderItemsQuery = "DELETE FROM orderitems WHERE orderId = ?";
//		try (Connection connection = Connect.getInstance().getConnection())
//		{
//			PreparedStatement prep = connection.prepareStatement(deleteOrderItemsQuery);
//			prep.setInt(1, orderId);
//			prep.executeUpdate();
//		}
//		catch (SQLException e)
//		{
//			e.printStackTrace();
//		}
//		
//		String reinsertOrderItemsQuery = "INSERT INTO orderitems (orderId, menuItemId, quantity) VALUES (?, ?, ?);";
//		try (Connection connection = Connect.getInstance().getConnection())
//		{
//			PreparedStatement prep = connection.prepareStatement(reinsertOrderItemsQuery);
//			for (OrderItem orderItem : orderItems) {
//				prep.setInt(1, orderId);
//				prep.setInt(2, orderItem.getMenuItem().getMenuItemId());
//				prep.setInt(3, orderItem.getQuantity());
//				prep.executeUpdate();
//				
//			}
//		}
//		catch (SQLException e)
//		{
//			e.printStackTrace();
//		}
		
		String updateQuery = "UPDATE orders SET orderStatus = ? WHERE orderId = ?;";
		try (Connection connection = Connect.getInstance().getConnection())
		{
			PreparedStatement prep = connection.prepareStatement(updateQuery);
			prep.setString(1, orderStatus);
			prep.setInt(2, orderId);
			prep.executeUpdate();
			return "success";
		}
		catch (SQLException e)
		{
			e.printStackTrace();
			return "failed";
		}
	}
	
	public static String deleteOrder(int orderId)
	{
		String query = "DELETE FROM orders WHERE orderId = ?";
		  
		try (Connection connection = Connect.getInstance().getConnection())
		{
			PreparedStatement prep = connection.prepareStatement(query);
			prep.setInt(1, orderId);
			prep.executeUpdate();
			return "success";
		}
		catch (SQLException e)
		{
			e.printStackTrace();
			return "failed";
		}
	}
	
	// VALIDATION

	public static double getTotalByOrderId(int orderId)
	{
		double orderTotalPrice = 0;
		String query = "SELECT * FROM orderitems JOIN menuitems ON orderitems.menuItemId = menuitems.menuItemId WHERE orderitems.orderId = ?;";
		  
		try (Connection connection = Connect.getInstance().getConnection())
		{
			PreparedStatement prep = connection.prepareStatement(query);
			prep.setInt(1, orderId);
			ResultSet resultSet = prep.executeQuery();
			
			while(resultSet.next())
			{
				int quantity = resultSet.getInt("quantity");
				double menuItemPrice = resultSet.getDouble("menuItemPrice");
				orderTotalPrice += (double) quantity * menuItemPrice;
			}
			resultSet.close();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		return orderTotalPrice;
	}
	
	// GETTERS & SETTERS
	
	public int getOrderId()
	{
		return orderId;
	}

	public void setOrderId(int orderId)
	{
		this.orderId = orderId;
	}

	public int getOrderUserId()
	{
		return orderUserId;
	}
	
	public void setOrderUserId(int orderUserId)
	{
		this.orderUserId = orderUserId;
	}
	
	public User getOrderUser() 
	{
		return orderUser;
	}

	public void setOrderUser(User orderUser)
	{
		this.orderUser = orderUser;
	}

	public ArrayList<OrderItem> getOrderItems()
	{
		return orderItems;
	}

	public void setOrderItems(ArrayList<OrderItem> orderItems)
	{
		this.orderItems = orderItems;
	}

	public String getOrderStatus()
	{
		return orderStatus;
	}

	public void setOrderStatus(String orderStatus)
	{
		this.orderStatus = orderStatus;
	}

	public Date getOrderDate()
	{
		return orderDate;
	}

	public void setOrderDate(Date orderDate)
	{
		this.orderDate = orderDate;
	}

	public double getOrderTotal()
	{
		return orderTotal;
	}

	public void setOrderTotal(double orderTotal)
	{
		this.orderTotal = orderTotal;
	}		
}
