## Registration

Registrations for meeting attendance and poster contributions will continuously be accepted till the **9th of February 2021**. The deadline for contributed talks and workshop attendance is on the **15th of January 2021**. 

Please, make sure you follow the guidelines for abstract and motivation letter submission; these can be found at the bottom of this page.

<form name="submit-to-google-sheet" id="form" onSubmit="alert('Thanks for your registration! We will check your submitted data and send you a confimatory email.');">
  <br>
  Name:<br>
  <input type="text" name="name" value="">
  <br><br>
  Email:<br>
  <input type="text" name="email" value="">
  <br><br>
  Affiliation:<br>
  <input type="text" name="affiliation" value="">
  <br><br>
  Do you want to contribute with an oral/poster presentation? <br>
  <input type="radio" name="question1" value="1"> No <br>
  <input type="radio" name="question1" value="2"> Yes, oral presentation only <br>
  <input type="radio" name="question1" value="3"> Yes, oral or poster presentation <br>
  <input type="radio" name="question1" value="4"> Yes, poster presentation <br><br>

  Abstract:<br>
  <textarea rows="4" cols="50" maxlength="2000" name="abstract"></textarea>
  <br><br>

  Do you want to attend the workshop?: <br>
  <input type="radio" name="question2" value="1"> No <br>
  <input type="radio" name="question2" value="2"> Yes <br><br>
  Motivation letter:<br>
  <textarea rows="4" cols="50"  maxlength="2000"  name="letter"></textarea>

  <br><br>
  <button type="submit">Send</button>
</form> 
<br>

<script>
  const scriptURL = 'https://script.google.com/macros/s/AKfycbyJClSf277gOQYgH2cxLkYSe6uXDj_1AE-Zl-0qc5YY4KEpOjJo/exec'
  const form = document.forms['submit-to-google-sheet']

  form.addEventListener('submit', e => {
    e.preventDefault()
    fetch(scriptURL, { method: 'POST', body: new FormData(form)})
      .then(response => console.log('Success!', response))
      .catch(error => console.error('Error!', error.message))
  })
</script>

**Abstract**
* The title should be placed in the first line.
* The authors' list goes in the second line. Affiliations should be identified with square brackets: e.g., [1,2].
* Affiliations' list goes in the third line. Identify each affiliation using square brackets and separate them using commas.
* Abstract text starts in the fourth line.
* Please do not include any references in your abstract. 
* Limit: 2000 characters.

<br>

**Motivation letter to attend the workshop**
* Explain the reasons why you want to participate in the workshop. 
* Preference will be given to participants that are currently performing phylogenomic analysis in real data. 
* Limit: 2000 characters.
