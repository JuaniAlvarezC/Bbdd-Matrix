--1--
SELECT c.customerId, c.firstName, c.lastName 
FROM Customer c 
    INNER JOIN Invoice i ON i.customerId = c.customerId 
    INNER JOIN InvoiceLine il ON il.invoiceId = i.invoiceId 
    INNER JOIN Track t ON t.trackId = il.trackId 
GROUP BY  c.customerId, c.firstName, c.lastName 
HAVING COUNT(DISTINCT t.genreId) = 1

--2--
SELECT c.customerId,c.firstName,c.lastName, c.Address,c.Email, e.firstName, e.lastName, COUNT(i.invoiceId) AS Invoices
FROM Customer c  
    INNER JOIN Employee e ON c.supportRepId = e.employeeId 
    INNER JOIN Invoice i ON i.customerId = c.customerId 
WHERE YEAR(i.invoiceDate) >= 2010 
GROUP BY c.customerId,c.firstName,c.lastName, c.Address,c.Email, e.firstName, e.lastName;

--3--
WITH invoice_counts AS (
    SELECT COUNT(*) AS Counts FROM Invoice WHERE YEAR(invoiceDate) >= 2010
)
SELECT c.customerId,c.firstName,c.lastName, c.Address,c.Email, e.firstName, e.lastName, invoice_counts.Counts
FROM Customer c  
    INNER JOIN Employee e ON c.supportRepId = e.employeeId 
    CROSS JOIN invoice_counts

--4--
SELECT g.GenreId, g.Name, COUNT(DISTINCT t.AlbumId) 
FROM Genre g 
    INNER JOIN Track t ON t.GenreId = g.GenreId 
GROUP BY g.GenreId, g.Name; 
--5--

WITH rock_tracks AS (
    SELECT p.playlistId, p.Name, COUNT(t.trackId) as rockCounts 
    FROM Playlist p 
        INNER JOIN PlaylistTrack pt ON pt.PlaylistId = p.playlistId 
        INNER JOIN Track t ON t.trackId = pt.trackId 
        INNER JOIN Genre g ON g.genreId = t.genreId
    WHERE g.Name = 'Rock'
    GROUP BY p.playlistId, p.Name 
)
SELECT playlistId,Name 
FROM rock_tracks
WHERE rockCounts = (SELECT MAX(r.rockCounts) FROM rock_tracks r)
--6--
SELECT * 
FROM Album al 
WHERE 10 < (SELECT COUNT(*) FROM Track t WHERE t.albumId = al.albumId)