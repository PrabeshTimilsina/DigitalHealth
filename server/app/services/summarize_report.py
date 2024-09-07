import google.generativeai as genai
from ..config import Config
import re
API_KEY=Config.GEMINI_APIKEY




def summarize_text(text):
    genai.configure(api_key=API_KEY)
    model = genai.GenerativeModel(model_name="gemini-1.5-flash")

    # Generate the content
    response = model.generate_content(['Summarize the following medical report into two sections: summary and findings:', text])

    # Clean up the response text
    cleaned_paragraph = re.sub(r'\s+', ' ', response.text)
    cleaned_paragraph = re.sub(r'/hpf', '', cleaned_paragraph)
    cleaned_paragraph = re.sub(r'\\n', ' ', cleaned_paragraph)
    cleaned_paragraph = re.sub(r'\*', '', cleaned_paragraph)
    cleaned_paragraph = re.sub(r'\-', '', cleaned_paragraph)
    
    # Initialize summary and findings as empty strings
    summary = ''
    findings = ''
    
    # Attempt to split based on "Summary" and "Findings"
    summary_match = re.search(r'Summary(.*?)(Findings|$)', cleaned_paragraph, re.IGNORECASE | re.DOTALL)
    findings_match = re.search(r'Findings(.*)', cleaned_paragraph, re.IGNORECASE | re.DOTALL)

    if summary_match:
        summary = summary_match.group(1).strip()
    if findings_match:
        findings = findings_match.group(1).strip()

    # Return separated summary and findings
    return {"summary": summary, "findings": findings}
