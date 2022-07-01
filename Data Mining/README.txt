NBA Stat Analysis for Outcome Prediction.
-Kyle Moe CSCI 4502-001B


Code Files Included (Ordered by Date of Creation):
Note that the later files will be more reflective of our final results while earlier ones demonstrate inital processes to prepare data and perform simple analyses.

- "Data Collection.ipynb"
Inital exploration of NBA_API team game data with simple Naive Bayes implementation to determine whether a game is a win or a loss given known team offensive data. Many functions are re-used in later notebooks such as changing stats to per-minute statistics.

- "Bayes.ipynb"
Begin collecting data from 2014-15 season to 2020-21 season. Clean data and merge home/away games so that Team A's stats and Team B's stats are contained in a single row for every game (makes it easier to apply more accurate analysis). 
Naive Bayes implementation using known stats from each team: >90% accuracy. 
Correlation matrix using seaborn between single team stats. 
Inital attempt at creating a simplistic predictor using sklearn linear model.

- "Predictor.ipynb"
Initial implementations of regression predictor. Initial predictor (named predictor) makes final score predictions for both teams using single team stats alone. Next predictor (also named predictor sorry) applies 50-50 split to team's average stats and their opponents past stats. 

- "Betting Data.ipynb"
Since obsolete extraction and integration of betting data from Kaggle Source. Included for posterity though this betting database was missing too many values and a separate one was used.

- "Betting.ipynb"
New extraction of betting data from Sportsbook Reviews Online. Reqired substantial manipulation to put into familiar table form.

- "Weighted Predictor.ipynb"
Several different predictors attempted in this notebook. Includes Bayes and regression predictors. Based on metrics like n recent games, season averages, home vs away averages, recent matchups, and an attempt to combine these influences. All predictors tested against betting lines: spread and over/under as well as against who actually won the game.

- "Rest Days.ipynb"
Exploration of relationship between rest days and travel days against point totals and point differentials. Use ordinary least squares and visualization.

- "Immutable Bayes.ipynb"
Attempt to combine Rest Days, Travel Days, Win Percentage, and Home/Away to create a Naive Bayes classifier for wins and losses. Not a particular robust predictor.

- "Result Collection.ipynb"
Aggregation and testing of Predictors found in "Weighted Preictor.ipynb". Intended to funciton as single notebook through which one could see a summary of predictor results. Varies number of recent games used for different predictors. Runs slowly, use mostly as observation tool for results listed. \



Datasets

20XX-XY away.csv, 20XX-XY full.csv, 20XX-XY home.csv represent iterative pieces of databases during manipulation/integration steps.

20XX-XY bets.csv Contains formatted betting data for given year. Extracted from "nba odds 20XX-XY.xlsx".

"nba_betting_....csv" These four databases are from the old betting data that is now obsolete. Retained to show iterative process of project. "betting.csv" is integrated form of this data.

"20XX-XY.csv" These files contain the full data used with all stats and betting data integrated. Robust through regular seasons from the years 2014-15 to 2020-21. 



