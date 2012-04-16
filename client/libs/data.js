var data = {
  "planets": [
    {
      "id":           "1",
      "name":         "X001",
      "x":            "50",
      "y":            "50",
      "level":        "1",
      "production":   "90",
      "shipsData":    [
        {
          "id":  1,
          "name": "A001"
        },
        {
          "id":  2,
          "name": "A002"
        },
        {
          "id":  3,
          "name": "A003"
        },
      ]
    },

    {
      "id":           "2",
      "name":         "X002",
      "x":            "100",
      "y":            "100",
      "level":        "1",
      "production":   "90",
      "shipsData":    [
        {
          "id":  4,
          "name": "A004"
        },
        {
          "id":  5,
          "name": "A005"
        },
        {
          "id":  6,
          "name": "A006"
        },
      ]
    },

    {
      "id":           "3",
      "name":         "X003",
      "x":            "200",
      "y":            "300",
      "level":        "1",
      "production":   "90",
      "shipsData":    [
        {
          "id":  7,
          "name": "A007"
        },
        {
          "id":  8,
          "name": "A008"
        },
        {
          "id":  9,
          "name": "A009"
        },
      ]
    },

  ],

  "fleets" : [
    {
      "id":             "1",
      "name":           "F001",
      "origin_id":      "1",
      "target_id": "3",
      "percent":        "23",
      "shipsData": [
        {
          "id":  4,
          "name": "A004"
        },
        {
          "id":  5,
          "name": "A005"
        },
        {
          "id":  6,
          "name": "A006"
        },
      ]
    },

    {
      "id":             "2",
      "name":           "F002",
      "origin_id":      "2",
      "target_id": "3",
      "percent":        "30",
      "shipsData": [
        {
          "id":  4,
          "name": "A004"
        }
      ]

    },


  ]
}