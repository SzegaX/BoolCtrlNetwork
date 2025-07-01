function outState=ppiStep(startState)
global W thetaCurrent
outState=W*startState>=thetaCurrent;