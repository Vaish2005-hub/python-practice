-- 86. Display category hierarchy
WITH RECURSIVE category_tree AS (
    SELECT category_id, category_name, parent_category_id,
-- 86. Display category hierarchy
WITH RECURSIVE category_tree AS (
    SELECT category_id, category_name, parent_category_id,
           1 AS level
    FROM CATEGORIES
    WHERE parent_category_id IS NULL

    UNION ALL

    SELECT c.category_id, c.category_name,
           c.parent_category_id, ct.level + 1
    FROM CATEGORIES c
    JOIN category_tree ct
    ON c.parent_category_id = ct.category_id
)
SELECT * FROM category_tree
ORDER BY level, category_id;


-- 87. Display sub-category tree
WITH RECURSIVE subcategory_tree AS (
    SELECT category_id, category_name, parent_category_id,
           category_name::TEXT AS category_path
    FROM CATEGORIES
    WHERE parent_category_id IS NULL

    UNION ALL

    SELECT c.category_id, c.category_name,
           c.parent_category_id,
           st.category_path || ' -> ' || c.category_name
    FROM CATEGORIES c
    JOIN subcategory_tree st
    ON c.parent_category_id = st.category_id
)
SELECT * FROM subcategory_tree
ORDER BY category_path;


-- 88. Display employee reporting hierarchy
WITH RECURSIVE employee_hierarchy AS (
    SELECT employee_id, employee_name, manager_id,
           designation, 1 AS level
    FROM EMPLOYEES
    WHERE manager_id IS NULL

    UNION ALL

    SELECT e.employee_id, e.employee_name, e.manager_id,
           e.designation, eh.level + 1
    FROM EMPLOYEES e
    JOIN employee_hierarchy eh
    ON e.manager_id = eh.employee_id
)
SELECT * FROM employee_hierarchy
ORDER BY level, employee_id;


-- 89. Find all managers and employees under them
WITH RECURSIVE employee_tree AS (
    SELECT employee_id AS manager_id,
           employee_id, employee_name, manager_id AS reporting_to,
           1 AS level
    FROM EMPLOYEES
    WHERE manager_id IS NULL

    UNION ALL

    SELECT et.manager_id, e.employee_id,
           e.employee_name, e.manager_id, et.level + 1
    FROM EMPLOYEES e
    JOIN employee_tree et
    ON e.manager_id = et.employee_id
)
SELECT m.employee_name AS top_manager,
       et.employee_name AS employee_name,
       et.level
FROM employee_tree et
JOIN EMPLOYEES m
ON et.manager_id = m.employee_id
WHERE et.level > 1
ORDER BY m.employee_name, et.level;


-- 90. Generate category depth levels
WITH RECURSIVE category_levels AS (
    SELECT category_id, category_name, parent_category_id,
           1 AS depth_level
    FROM CATEGORIES
    WHERE parent_category_id IS NULL

    UNION ALL

    SELECT c.category_id, c.category_name,
           c.parent_category_id, cl.depth_level + 1
    FROM CATEGORIES c
    JOIN category_levels cl
    ON c.parent_category_id = cl.category_id
)
SELECT * FROM category_levels
ORDER BY depth_level, category_id;
