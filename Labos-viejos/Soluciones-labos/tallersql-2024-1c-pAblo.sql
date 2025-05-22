--1--
SELECT i.invoiceId
FROM Invoice i 
    INNER JOIN InvoiceLine il ON il.invoiceId = i.invoiceId 
GROUP BY i.invoiceId 
HAVING COUNT(*) > 5
ORDER BY i.invoiceId DESC
--2--
WITH album_sales AS (
    SELECT al.albumId, al.Title, COUNT(DISTINCT il.InvoiceId) as Sales
    FROM Album al 
        INNER JOIN Track t ON t.albumId = t.albumId 
        INNER JOIN InvoiceLine il ON il.trackId = t.trackId 
    GROUP BY al.AlbumId, al.Title
)
SELECT albumId, Title 
FROM album_sales
WHERE album_sales.Sales = (SELECT MAX(Sales) from album_sales)
--3--
SELECT al.Title
FROM Album al 
    INNER JOIN Track t ON al.albumId = t.albumId 
    INNER JOIN PlaylistTrack pt ON pt.trackId = t.trackId 
GROUP BY al.albumId,al.Title 
HAVING COUNT(DISTINCT pt.playlistId) = 1
--4--
SELECT al.AlbumId, al.Title
FROM Album al 
    INNER JOIN Track t ON al.albumId = t.albumId 
GROUP BY al.albumId,al.Title 
HAVING SUM(CAST(t.Bytes AS BIGINT)) > 1500000
--5--
SELECT DISTINCT p.playlistId,p.Name
FROM Playlist p 
    INNER JOIN PlaylistTrack pt ON p.playlistId = pt.playlistId
    INNER JOIN Track t ON t.trackId = pt.trackId
    INNER JOIN Genre g ON g.GenreId = t.GenreId 
WHERE g.Name = 'Rock' AND NOT EXISTS (
    SELECT *
    FROM PlaylistTrack pt2 
        INNER JOIN Track t2 ON t2.trackId = pt2.trackId 
        INNER JOIN Genre g2 ON g2.GenreId = t2.GenreId 
        WHERE pt2.playlistId = p.playlistId AND g2.Name = 'Blues'
)
--6--
WITH artist_self_references AS (
    SELECT a.artistId,a.Name, COUNT(*) as selfReferences
    FROM Artist a 
        INNER JOIN Album al ON a.artistId = al.artistId
        INNER JOIN Track t ON t.albumId = al.albumId 
    WHERE t.Name = al.Title
    GROUP BY a.artistId,a.Name
)
SELECT a.Name 
FROM artist_self_references 
WHERE artist_self_references.selfReferences = (SELECT MAX(selfReferences) FROM artist_self_references)