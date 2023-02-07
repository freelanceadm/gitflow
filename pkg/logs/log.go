package logs

import (
	log "github.com/sirupsen/logrus"
)

// Create and setup logrus

func init() {
	// Enable log of calling function
	log.SetReportCaller(true)

	// Setup log format
	formatter := &log.TextFormatter{
		ForceQuote:    true,
		FullTimestamp: true,
	}

	// Apply format for our logger
	log.SetFormatter(formatter)
}
