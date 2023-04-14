import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
	return MaterialApp(
	home: HomePage(),
	);
}
}

class HomePage extends StatefulWidget {
@override
_HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
bool oTurn = true;

// 1st player is O
List<String> elementToDisplay = ['', '', '', '', '', '', '', '', ''];
int oPoints = 0;
int xPoints = 0;
int usedBoxes = 0;

@override
Widget build(BuildContext context) {
	return Scaffold(
	backgroundColor: Colors.purple[800],
	body: Column(
		children: <Widget>[
		Expanded(
			child: Container(
			child: Row(
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
				Padding(
					padding: const EdgeInsets.all(30.0),
					child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						Text(
						'Player X',
						style: TextStyle(fontSize: 20,
										fontWeight: FontWeight.bold,
										color: Colors.yellow),
						),
						Text(
              xPoints.toString(),
              style: TextStyle(fontSize: 20,color: Colors.yellow),
						),
					],
					),
				),
				Padding(
					padding: const EdgeInsets.all(30.0),
					child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						Text('Player O', style: TextStyle(fontSize: 20,
														fontWeight: FontWeight.bold,
														color: Colors.yellow)
						),
						Text(
              oPoints.toString(),
              style: TextStyle(fontSize: 20,color: Colors.yellow),
						),
					],
					),
				),
				],
			),
			),
		),
		Expanded(
			flex: 4,
      child: Container(
        width: 450,
        height: 450,
        child: GridView.builder(
          itemCount: 9,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index) 
          {
          return GestureDetector(
            onTap: () {
            _tapped(index);
            },
            child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.yellow)),
            child: Center(
              child: Text(
              elementToDisplay[index],
              style: TextStyle(color: Colors.yellow, fontSize: 35),
              ),
            ),
            ),
          );
          }),
      )
		),
		Expanded(
			child: Container(
			child: Row(
			mainAxisAlignment: MainAxisAlignment.center,
			children: <Widget>[
				 ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.purple[50],
          onPrimary: Colors.black
        ),
				onPressed: _clearScoreBoard,
				child: Text("Clear Score Board"),
				),
			],
			),
		))
		],
	),
	);
}

void _tapped(int index) {
	setState(() 
  {
    if (oTurn && elementToDisplay[index] == '') 
    {
      elementToDisplay[index] = 'O';
      usedBoxes++;
    } 
    else if (!oTurn && elementToDisplay[index] == '') 
    {
      elementToDisplay[index] = 'X';
      usedBoxes++;
    }

    oTurn = !oTurn;
    _checkWinner();
	});
}

void _checkWinner() {
	
	// Checking rows
	if (elementToDisplay[0] == elementToDisplay[1] &&
		elementToDisplay[0] == elementToDisplay[2] &&
		elementToDisplay[0] != '') 
    {
    _showWinDialog(elementToDisplay[0]);
    }
	if (elementToDisplay[3] == elementToDisplay[4] &&
		elementToDisplay[3] == elementToDisplay[5] &&
		elementToDisplay[3] != '') 
    {
    _showWinDialog(elementToDisplay[3]);
    }
	if (elementToDisplay[6] == elementToDisplay[7] &&
		elementToDisplay[6] == elementToDisplay[8] &&
		elementToDisplay[6] != '') 
    {
    _showWinDialog(elementToDisplay[6]);
    }

	// Checking Column
	if (elementToDisplay[0] == elementToDisplay[3] &&
		elementToDisplay[0] == elementToDisplay[6] &&
		elementToDisplay[0] != '') 
    {
    _showWinDialog(elementToDisplay[0]);
    }
	if (elementToDisplay[1] == elementToDisplay[4] &&
		elementToDisplay[1] == elementToDisplay[7] &&
		elementToDisplay[1] != '') 
    {
    _showWinDialog(elementToDisplay[1]);
    }
	if (elementToDisplay[2] == elementToDisplay[5] &&
		elementToDisplay[2] == elementToDisplay[8] &&
		elementToDisplay[2] != '') 
    {
    _showWinDialog(elementToDisplay[2]);
    }

	// Checking Diagonal
	if (elementToDisplay[0] == elementToDisplay[4] &&
		elementToDisplay[0] == elementToDisplay[8] &&
		elementToDisplay[0] != '') 
    {
    _showWinDialog(elementToDisplay[0]);
    }
	if (elementToDisplay[2] == elementToDisplay[4] &&
		elementToDisplay[2] == elementToDisplay[6] &&
		elementToDisplay[2] != '') 
    {
	  _showWinDialog(elementToDisplay[2]);
	  } 
  else if (usedBoxes == 9) 
    {
    _showDrawDialog();
    }
}

void _showWinDialog(String winner) {
	showDialog(
		barrierDismissible: false,
		context: context,
		builder: (BuildContext context) {
		return AlertDialog(
			title: Text("\" " + winner + " \" is Winner!!!"),
			actions: [
			OutlinedButton(
				child: Text("Play Again"),
				onPressed: () {
				_clearBoard();
				Navigator.of(context).pop();
				},
			)
			],
		);
		});

	if (winner == 'O') {
	oPoints++;
	} else if (winner == 'X') {
	xPoints++;
	}
}

void _showDrawDialog() {
	showDialog(
		barrierDismissible: false,
		context: context,
		builder: (BuildContext context) {
		return AlertDialog(
			title: Text("Draw"),
			actions: [
			OutlinedButton(
				child: Text("Play Again"),
				onPressed: () {
				_clearBoard();
				Navigator.of(context).pop();
				},
			)
			],
		);
		});
}

void _clearBoard() {
	setState(() {
	for (int i = 0; i < 9; i++) {
		elementToDisplay[i] = '';
	}
	});

	usedBoxes = 0;
}

void _clearScoreBoard() {
	setState(() {
	xPoints = 0;
	oPoints = 0;
	for (int i = 0; i < 9; i++) {
		elementToDisplay[i] = '';
	}
	});
	usedBoxes = 0;
}
}
