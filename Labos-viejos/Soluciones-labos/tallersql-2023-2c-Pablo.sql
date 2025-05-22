--1--
SELECT i.BillingCountry, COUNT(i.invoiceId)
FROM Invoice i 
GROUP BY i.BillingCountry
--2--
SELECT c.CustomerId, sum(i.total)
FROM Customer c 
    INNER JOIN Invoice i ON i.CustomerId = c.customerId 
GROUP BY c.customerId 
HAVING sum(i.total) > 40
ORDER BY sum(i.total) DESC
--3--
WITH album_counts AS (
    SELECT COUNT(DISTINCT al.albumId) AS Count
    FROM Album al
    INNER JOIN Track t ON t.albumId = al.albumId 
    INNER JOIN PlaylistTrack pt ON pt.trackId = t.trackId 
    INNER JOIN Playlist p ON p.PlaylistId = pt.PlaylistId
GROUP BY p.PlaylistId
)
SELECT AVG(Count) FROM album_counts 
--4--
SELECT e.EmployeeId, YEAR(i.InvoiceDate) as Year, COUNT(*) as Sales
FROM Employee e 
    INNER JOIN Customer c ON c.SupportRepId = e.EmployeeId
    INNER JOIN Invoice i ON i.customerId = c.customerId 
GROUP BY  YEAR(i.InvoiceDate),e.EmployeeId
ORDER BY COUNT(*) DESC
--5--
SELECT DISTINCT p.playlistId,p.name,g.GenreId,g.Name
FROM Playlist p 
    INNER JOIN PlaylistTrack pt ON p.playlistId = pt.playlistId
    INNER JOIN Track t ON t.trackId = pt.trackId 
    INNER JOIN Genre g ON g.GenreId = t.GenreId
WHERE NOT EXISTS (
    SELECT * FROM PlaylistTrack pt2
        INNER JOIN Track t2 ON t2.trackId = pt2.trackId
    WHERE pt2.playlistId = p.playlistId AND t2.GenreId != g.GenreId)
--6--
SELECT g.Genreid, g.name
FROM Genre g 
    LEFT OUTER JOIN Track t ON g.GenreId = t.GenreId 
    LEFT OUTER JOIN PlaylistTrack pt ON pt.trackId = t.trackId
WHERE pt.trackId IS NULL