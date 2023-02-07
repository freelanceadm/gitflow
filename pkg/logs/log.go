package logs

import (
	"os"

	"github.com/sirupsen/logrus"
)

// Create and setup logrus
var L *logrus.Logger

func init() {
	// Create logger
	L = logrus.New()

	// Enable log of calling function
	L.SetReportCaller(true)

	// Setup log format
	formatter := &logrus.TextFormatter{
		ForceQuote:    true,
		FullTimestamp: true,
	}

	// Apply format for our logger
	L.SetFormatter(formatter)

	// Set output
	L.SetOutput(os.Stdout)

	// Enable debug
	L.SetLevel(logrus.DebugLevel)
}
