-- 1
SELECT c.FirstName, c.LastName
FROM customer c
JOIN invoice i ON i.customerId = c.customerId
JOIN invoiceLine il ON il.invoiceId = i.invoiceId
JOIN track t ON t.TrackId = il.TrackId
JOIN genre g ON g.GenreId = t.GenreId
GROUP BY c.customerId, c.FirstName, c.LastName
HAVING COUNT(DISTINCT g.GenreId) = 1

-- 2
SELECT c.FirstName, c.LastName, c.address, e.FirstName AS employeeFirstName, e.LastName AS employeeLastName , COUNT(i.InvoiceId) AS facturas
FROM customer c
JOIN employee e ON e.EmployeeId = c.SupportRepId
JOIN invoice i ON i.CustomerId = c.CustomerId
WHERE YEAR(i.InvoiceDate) > 2010
GROUP by c.CustomerId, c.FirstName, c.LastName, c.address, e.FirstName, e.LastName;

-- 3

--4
SELECT g.GenreId, g.Name, COUNT(DISTINCT al.AlbumId) AS amountOfAlbums
FROM genre g
JOIN track t ON t.GenreId = g.GenreId
JOIN album al ON al.AlbumId = t.AlbumId
GROUP BY g.GenreId, g.Name;

--5 
WITH rockTracks AS (
    SELECT pl.PlaylistId, pl.Name, COUNT(DISTINCT t.TrackId) AS amount
    FROM playlist pl
    JOIN playlisttrack plt ON plt.PlaylistId = pl.PlaylistId
    JOIN track t ON t.TrackId = plt.TrackId
    JOIN genre g ON g.GenreId = t.GenreId
    WHERE g.name = 'Rock'
    GROUP BY pl.PlaylistId, pl.Name
), maxRockTracks AS (
    SELECT MAX(rt.amount) as maxAmount
    FROM rockTracks rt
)
SELECT rt.PlaylistId, rt.name
FROM rockTracks rt
JOIN maxRockTracks mrt ON rt.amount = mrt.maxAmount;

--6
SELECT al.AlbumId, al.Title
FROM album al
WHERE (
    SELECT COUNT(*)
    FROM track t
    WHERE t.AlbumId = al.AlbumId
) > 10