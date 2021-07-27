
;with RData AS(
SELECT [match_day], [name], [hand], [score] , [attempts], RANK()OVER (PARTITION BY match_day ORDER BY score DESC) AS [Rank], SUM(CAST(score AS FLOAT)) OVER (PARTITION BY match_day ORDER BY score DESC) / 2 AS [Avg]
FROM [dbo].[Rdata]
)
SELECT [match_day], [name], [hand], [score], [attempts], [Avg], [Rank], CASE  WHEN  [score] <> [Avg]  AND [Rank] = 1 THEN 'Won' WHEN [score] <> [Avg]  AND [Rank] = 2 THEN 'Lost' ELSE 'Tie' END [Status] 
FROM RData
