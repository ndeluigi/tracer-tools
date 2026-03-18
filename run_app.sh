#!/bin/bash
# Launcher script for Tracer Tools (Mac/Linux)

echo "Starting Tracer Tools..."
echo ""

# Check if R is installed in PATH
if command -v Rscript &> /dev/null
then
    RSCRIPT_PATH="Rscript"
else
    # R not in PATH - check if config file exists
    if [ -f "r_path.txt" ]; then
        RSCRIPT_PATH=$(cat r_path.txt)
        if [ -f "$RSCRIPT_PATH" ]; then
            echo "Using R from: $RSCRIPT_PATH"
        else
            RSCRIPT_PATH=""
        fi
    fi
    
    # R not found - ask user for path
    if [ -z "$RSCRIPT_PATH" ]; then
        echo "R is not found in PATH."
        echo ""
        echo "Please provide the full path to Rscript"
        echo "Common locations:"
        echo "  /usr/bin/Rscript"
        echo "  /usr/local/bin/Rscript"
        echo "  /Library/Frameworks/R.framework/Resources/bin/Rscript (Mac)"
        echo ""
        read -p "Enter full path to Rscript: " RSCRIPT_PATH
        
        # Validate the path
        if [ ! -f "$RSCRIPT_PATH" ]; then
            echo ""
            echo "ERROR: File not found: $RSCRIPT_PATH"
            echo "Please install R from https://cran.r-project.org/"
            echo ""
            exit 1
        fi
        
        # Save the path for future use
        echo "$RSCRIPT_PATH" > r_path.txt
        echo ""
        echo "Path saved to r_path.txt for future use."
        echo ""
    fi
fi

# Run the Shiny app
echo "Opening Tracer Tools in your browser..."
"$RSCRIPT_PATH" -e "shiny::runApp('app.R', launch.browser = TRUE)"
