def generate_pick():

    probability=82
    market_odds=1.92

    implied=100/market_odds

    edge=(probability-implied)

    if edge > 5:
        return {

         "match":"Arsenal vs Chelsea",
         "market":"Over 2.5",
         "odds":1.92,
         "confidence":probability,
         "edge":round(edge,2),
         "grade":"A+"

        }

    return None