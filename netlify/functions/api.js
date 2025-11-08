exports.handler = async (event, context) => {


  const sheets = [
    { id: 'basics', name: 'Basics' },
    { id: 'iota', name: 'Iota' },
    { id: 'verbs', name: 'Verbs' },
    { id: 'pronouns', name: 'Pronouns' },
    { id: 'numbers', name: 'Numbers' }
  ]


  // Set headers to enable CORS
  const headers = {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Headers": "Content-Type",
    "Access-Control-Allow-Methods": "GET, POST",
  }

  if (event.httpMethod === "GET") {
    try {
      // Process the GET request as needed
      const currentSheet = sheets[0]

      // Load data for current sheet
      const api = `https://opensheet.elk.sh/1x_BUYpryHseve8-NFiby2ZyVnlWYjcn9-0oPIYhQbPM/${currentSheet.id}`
      const response = await fetch(api)
      const data = await response.json()

      // Return the data as the response
      return {
        statusCode: 200,
        headers,
        body: JSON.stringify(data),
      }
    } catch (error) {
      // Return an error response if there was an issue processing the request
      return {
        statusCode: 500,
        headers,
        body: JSON.stringify({ error: "Failed to process GET request" }),
      }
    }
  }
   else {
    // Handle other HTTP methods (e.g., PUT, DELETE) if needed
    return {
      statusCode: 405,
      headers,
      body: JSON.stringify({ error: "Method not allowed" }),
    }
  }
}
