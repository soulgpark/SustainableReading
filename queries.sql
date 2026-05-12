SELECT
    b.Title AS BookTitle,
    f1.Type AS FormatType1,
    f2.Type AS FormatType2,
    ei1.CarbonEmission AS CarbonEmission1,
    ei2.CarbonEmission AS CarbonEmission2,
    CASE
        WHEN ei1.CarbonEmission > ei2.CarbonEmission THEN
            CONCAT('The e-book reduces carbon emissions by ',
                ROUND(((ei1.CarbonEmission - ei2.CarbonEmission) / ei1.CarbonEmission) * 100, 2),
                '% compared to the paper book.')
        ELSE
            CONCAT('The paper book reduces carbon emissions by ',
                ROUND(((ei2.CarbonEmission - ei1.CarbonEmission) / ei2.CarbonEmission) * 100, 2),
                '% compared to the e-book.')
    END AS Recommendation
FROM Books b
JOIN Formats f1 ON b.BookID = f1.BookID
JOIN Formats f2 ON b.BookID = f2.BookID
    AND f1.Type = 'Paper'
    AND f2.Type = 'E-Book'
JOIN EnvironmentalImpact ei1 ON f1.FormatID = ei1.FormatID
JOIN EnvironmentalImpact ei2 ON f2.FormatID = ei2.FormatID
WHERE b.Title = 'The Vegetarian';
