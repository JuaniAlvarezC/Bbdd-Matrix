-- 1
SELECT i.InvoiceId
FROM Invoice i
JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
GROUP BY i.InvoiceId
HAVING COUNT(il.InvoiceLineId) > 5
ORDER BY i.InvoiceId DESC

-- 2
WITH InvoiceCount AS (
    SELECT al.albumId, COUNT(DISTINCT il.InvoiceId) as amount
    FROM album al
    JOIN track t ON t.albumId = al.albumId
    JOIN InvoiceLine il ON il.trackId = t.TrackId
    GROUP BY al.albumId
), maxInvoiceCount AS (
    SELECT MAX(amount) AS maxAmount FROM InvoiceCount
)
SELECT al.albumId, al.title 
FROM album al
JOIN InvoiceCount ic ON ic.albumId = al.albumId
JOIN maxInvoiceCount mic ON mic.maxAmount = ic.amount

-- 3
SELECT al.title
FROM album al
JOIN track t ON t.albumId = al.albumId
JOIN playlisttrack plt ON plt.trackId = t.trackId
GROUP BY al.albumId, al.title
HAVING COUNT(plt.playlistId) = 1

-- 4
WITH albumBytes AS (
    SELECT al.albumId, al.title, SUM(t.bytes / 1000) as bytes
    FROM album al
    JOIN track t ON t.albumId = al.albumId
    GROUP BY al.albumId, al.title
)
SELECT al.albumId, al.title
FROM album al
JOIN albumBytes alb ON alb.albumId = al.albumId
WHERE alb.bytes < 1500

-- 5
WITH playlistWithBluesGenre AS (
    SELECT pl.playlistId
    FROM playlist pl
    JOIN playlisttrack plt ON plt.playlistId = pl.playlistId
    JOIN track t ON t.trackId = plt.trackId
    JOIN genre g ON g.genreId = t.genreId
    WHERE g.name = 'BLUES'
    GROUP BY pl.playlistId, pl.name
)   
SELECT pl.playlistId, pl.name
FROM playlist pl
JOIN playlisttrack plt ON plt.playlistId = pl.playlistId
JOIN track t ON t.trackId = plt.trackId
JOIN genre g ON g.genreId = t.genreId
WHERE g.name = 'Rock' AND pl.playlistId NOT IN (SELECT PlaylistId FROM playlistWithBluesGenre)
GROUP BY pl.playlistId, pl.name;

-- 6
WITH composers AS (
    SELECT t.Composer, COUNT(DISTINCT al.albumId) as amount
    FROM Album al
    JOIN track t ON t.AlbumId = al.AlbumId
    WHERE al.Title = t.name AND t.Composer IS NOT NULL
    GROUP BY t.Composer
)
SELECT Composer
FROM composers
WHERE amount = (SELECT MAX(amount) FROM composers)