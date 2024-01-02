SELECT * FROM employees;
SELECT * FROM employee_orders;
SELECT * FROM orders;
/*# Task1: Use the ANY operator to identify all employees with the Order Status 'Completed'. 
	# Setting the filter that will be inside the ANY clause
    SELECT OrderID, Status
	FROM employee_orders
	WHERE Status = "Completed";
    
    # Query without filter
    SELECT employees.EmployeeName, employee_orders.Status AS "OrderStatus", employee_orders.OrderID
	FROM employees INNER JOIN employee_orders
	ON employees.EmployeeID = employee_orders.EmployeeID;
    
    #Complete query
    SELECT employees.EmployeeName, employee_orders.Status AS "OrderStatus", employee_orders.OrderID
	FROM employees INNER JOIN employee_orders
	ON employees.EmployeeID = employee_orders.EmployeeID
	WHERE Status = ANY(
		SELECT Status
		FROM employee_orders
		WHERE Status = "Completed"
	);

	# SOLUTION
        SELECT EmployeeID, EmployeeName
        FROM employees
        WHERE EmployeeID = ANY (SELECT EmployeeID FROM employee_orders WHERE Status = "Completed");
    */

/*# Task 2: Use the ALL operator to identify the IDs of employees who earned a handling cost of "more than 20% of the order value"
	# from all orders they have handled.

	# Testing select statement that will be inside parenthesis of ALL clause
    SELECT employee_orders.HandlingCost, orders.OrderTotal, employee_orders.HandlingCost/orders.OrderTotal AS "Cost2OrderRatio",
    orders.OrderID, employees.EmployeeName
    FROM employee_orders INNER JOIN orders
    ON employee_orders.OrderID = orders.OrderID
    INNER JOIN employees
    ON employee_orders.EmployeeID = employees.EmployeeID;
    #HAVING Cost2OrderRatio > 0.2;
	
    # Now the real SQL query
	SELECT employees.EmployeeID, employees.EmployeeName, employee_orders.Status AS "OrderStatus", 
    employee_orders.HandlingCost/orders.OrderTotal AS "Cost2OrderRatio", orders.OrderID
	FROM employees INNER JOIN employee_orders
	ON employees.EmployeeID = employee_orders.EmployeeID
    INNER JOIN orders
    ON employee_orders.OrderID = orders.OrderID;

    # Now doing the filtering (Did not know how to do it with ALL clause)
    SELECT MIN(employees.EmployeeID) AS "EmployeeID", employees.EmployeeName,
    MIN(employee_orders.HandlingCost/orders.OrderTotal) AS "MinCost2OrderRatio"#, orders.OrderID
	FROM employees INNER JOIN employee_orders
	ON employees.EmployeeID = employee_orders.EmployeeID
    INNER JOIN orders
    ON employee_orders.OrderID = orders.OrderID
	GROUP BY EmployeeName
    HAVING MinCost2OrderRatio > 0.2;
    
    #SOLUTION
		SELECT EmployeeID,HandlingCost
        FROM employee_orders
        WHERE HandlingCost > ALL(SELECT ROUND(OrderTotal/100 * 20) FROM orders); 
    */
/*# Task 3: Use the GROUP BY clause to summarize the duplicate records with the same column values into a single record by
	# grouping them based on those columns.
    
	SELECT Department FROM orders GROUP BY Department;
    
    #SOLUTION
		SELECT EmployeeID,HandlingCost
        FROM employee_orders
        WHERE HandlingCost > ALL(SELECT ROUND(OrderTotal/100 * 20) FROM orders) GROUP BY EmployeeID,HandlingCost;
*/
/*# Task 4: Use the HAVING clause to filter the grouped data in the subquery that you wrote in task 3 to filter the 20% OrderTotal
	# values to only retrieve values that are more than $100.
    
    SELECT employees.EmployeeID AS "EmployeeID", employees.EmployeeName,
    employee_orders.HandlingCost/orders.OrderTotal AS "MinCost2OrderRatio", orders.OrderTotal
	FROM employees INNER JOIN employee_orders
	ON employees.EmployeeID = employee_orders.EmployeeID
    INNER JOIN orders
    ON employee_orders.OrderID = orders.OrderID
    WHERE OrderTotal > 100;
    
    # SOLUTION
		SELECT EmployeeID,HandlingCost
        FROM employee_orders
        WHERE HandlingCost > ALL(
			SELECT ROUND(OrderTotal/100 * 20) AS twentyPercent
			FROM orders
            GROUP BY OrderTotal
            HAVING twentyPercent > 100)
		GROUP BY EmployeeID,HandlingCost;
*/