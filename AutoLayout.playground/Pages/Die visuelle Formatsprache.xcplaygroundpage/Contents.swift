//: [Previous](@previous)
import UIKit
import XCPlayground
/*:
# Die visuelle Formatsprache

## Einleitung

Mit der visuellen Fromatsprache (Visual Format Language) kannst du *sehr viele* der alltäglichen Benutzeroberflächen erstellen. Ein solcher Formatstring sieht zum Beipiel wie folgt aus `"|-[saveButton(70)]"`. Dieses Beispiel beschreibt eine Anordnung, in der der `saveButton` einen Standardabstand (meist sind das 8 Punkte) von linken Rand seiner Superview und eine Breite von 70 Punkten hat.

Im folgenden wollen wir uns versiedene Layouts anschauen und wie diesen mit der visuellen Formatsprache beschrieben werden.

## Die Vorbereitungen

Zunächst erzeugen wir uns ein View, mit auf der wir die Testviews platzieren können. Damit sich die View vom Hintergrund absetzt, setzen wir ihre Hintergrundfarbe auf Gelb.
*/
let hostView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
hostView.backgroundColor = UIColor.yellowColor()
XCPShowView("Host View", view: hostView)
/*:
Der Befehlt `XCPShowView("Host View", view: hostView)` zeigt die `hostView` im Assistant-Editor an.
Er wird aber auch benötigt, wenn wir die View mit all ihren Subviews inline im Playground anzeigen wollen.
*/
hostView

/*:
Um Layout-Constraints in Aktion beobachten zu können, benötigen wir Subviews, die wir auf der Host-View plazieren. Für die Erzeugung dieser Subviews definieren wir eine kleine Closure. Das selbe ließe sich mit einer Funktion erreichen. 
*/
let makeView = { (color: UIColor) -> UIView in
  let view = UIView(frame: CGRect.zeroRect)
  view.translatesAutoresizingMaskIntoConstraints = false
  view.backgroundColor = color
  return view
}
/*:
Wichtig dabei ist, wenn wir Layout-Constraints im Code erzeugen wollen, müssen wir für die jeweilige View `translatesAutoresizingMaskIntoConstraints` auf `false` setzen. Wenn wir das nicht tun, erzeugt Xcode für uns Constraints, die dann in der Regel mit den von uns gesetzten Constraints kollidieren. Auf der Seite [Häufige Fehler](Häufige%20Fehler) kannst du ein Beispiel finden, wie das dann aussieht.

Wir erzeugen drei farbige Views (rot, blau und grün) und fügen die ersten beiden gleich zur Host-View hinzu.
*/
let redView = makeView(UIColor.redColor())
hostView.addSubview(redView)

let blueView = makeView(UIColor.blueColor())
hostView.addSubview(blueView)

let greenView = makeView(UIColor.greenColor())

/*:
## Eine einfache Subview
*/
var constraints = [NSLayoutConstraint]()
constraints += NSLayoutConstraint.constraintsWithVisualFormat("|-[red]-|", options: [], metrics: nil, views: ["red": redView])
constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|[red]|", options: [], metrics: nil, views: ["red": redView])
//: *There is a bug in Playgrounds right now. You cannot show a view inline with the constraints* `"|[red]|"` *and* `"V:|[red]|"`*.*
NSLayoutConstraint.activateConstraints(constraints)
hostView
/*:
Die Klassenmethode `constraintsWithVisualFormat(_:options:metrics:views:)` der Klasse `NSLayoutConstraint` erzeugt aus Formatstrings Layout-Constraints. Diese werden in ein Array gespeichert und mit der Klassenmethode `activateConstraints(_:)` activiert. Diese Methode findet selbstständig heraus welche View die Constraints halten soll.

Schauen wir uns den ersten Formatstring "|-[red]-|" genauer an.

Das Zeichen `|` ist eine Seite der Superview. Ein Bindestrich alleine ist ein Standardabstand. Somit bedeutet `"|-"` ein Standardabstand vom linken Rand der Superview. Als nächstes haben wir ein Element der Benutzeroberfläche, in diesem Fall die rote View. Subviews werden in eckigen Klammern gesetzt. Somit beschreibt `"[red]"` die rote View.

Im Prinzip lässt sich das wie ein Bauplan lesen.

Wir könnten das Layout noch weiter spezifizieren (`options`, `metrics`). Wie das geht wird weiter unten beschrieben.

Der letzte Parameter der `constraintsWithVisualFormat(_:options:metrics:views:)`-Methode ist ein Dictionary, dass die Bezeichner aus dem Formatstring (`"rec"`) mit der View (`redView`) in Verbindungs setzt. Ohne dieses Dictionary weiss die Methode nicht, was die Bezeichner im Formatstring überhaupt bedeuten sollen. Auf der Seite [Häufige Fehler](Häufige%20Fehler) schauen wir uns an, was passiert, wenn ein Element im views-Dictionary fehlt.
*/

// Remove constraints again
NSLayoutConstraint.deactivateConstraints(constraints)
constraints.removeAll()

/*:
Die visuelle Formatsprache definiert Constraints in einem Strings. Um eine Verknüpfung zwischen den im Formatstring enthaltenen Elementen und den View-Objekten
*/
var views = ["red": redView, "blue": blueView, "green": greenView]

/*:
## Explizite Höhe und Breite
*/

constraints += NSLayoutConstraint.constraintsWithVisualFormat("|-[red]-[blue(30)]-|", options: [], metrics: nil, views: views)
constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-[red]-|", options: [], metrics: nil, views: views)
constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-[blue(20)]", options: [], metrics: nil, views: views)
NSLayoutConstraint.activateConstraints(constraints)

hostView

// Remove constraints again
NSLayoutConstraint.deactivateConstraints(constraints)
constraints.removeAll()

/*:
---
## Optionen
*/

constraints += NSLayoutConstraint.constraintsWithVisualFormat("|-[red]-[blue(30)]-|", options: [.AlignAllTop, .AlignAllBottom], metrics: nil, views: views)
constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-[red]-|", options: [], metrics: nil, views: views)
NSLayoutConstraint.activateConstraints(constraints)

hostView

// Remove constraints again
NSLayoutConstraint.deactivateConstraints(constraints)
constraints.removeAll()

/*:
## Eine weitere Ebene in der View-Hirarchy
*/

redView.addSubview(greenView)

constraints += NSLayoutConstraint.constraintsWithVisualFormat("|-[red]-[blue(30)]-|", options: [.AlignAllTop, .AlignAllBottom], metrics: nil, views: views)
constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-[red]-|", options: [], metrics: nil, views: views)
constraints += NSLayoutConstraint.constraintsWithVisualFormat("|-20-[green]-20-|", options: [], metrics: nil, views: views)
constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[green]-20-|", options: [], metrics: nil, views: views)
NSLayoutConstraint.activateConstraints(constraints)

hostView

/*:
##  Prioritäten und Ungleichheiten
*/

// Remove constraints again
NSLayoutConstraint.deactivateConstraints(constraints)
constraints.removeAll()

constraints += NSLayoutConstraint.constraintsWithVisualFormat("|-[red]-[blue(30)]-|", options: [.AlignAllTop, .AlignAllBottom], metrics: nil, views: views)
constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-[red]-|", options: [], metrics: nil, views: views)
constraints += NSLayoutConstraint.constraintsWithVisualFormat("|-20-[green(>=50)]-20@750-|", options: [], metrics: nil, views: views)
constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[green]-20-|", options: [], metrics: nil, views: views)
NSLayoutConstraint.activateConstraints(constraints)


hostView

hostView.frame.size.width = 130

hostView

/*:
## Der Assistant-Editor

Falls der Assistant-Editor nicht angezeigt wird, wähle folgenden Menüpunkt aus `View > Assistant Editor > Show Assitant Editor`.

![](OpenAssistantEditor.png)
*/


//: [Next](@next)
