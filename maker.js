function copy(){
    const bodyDiv = document.querySelector(".div");
    const filePath = 'psfile/empty.ps1';
    // if(!bodyDiv){
    //     CreateDiv();
    // }else{
    if(bodyDiv){
        bodyDiv.remove();
    }

    fetch(filePath)
        .then(res => {
            if(!res.ok){
                throw new Error(`Failed to fetch ${filePath}: ${res.statusText}`);
            }
            return res.text();
        })
        .then(psCode => {
            appendToHTML(psCode);
            console.log(psCode);
        })
        .catch(error => {
            console.error(error);
            //lert('Failed to fetch the PowerShell script.');
        });
}


copy();

function appendToHTML(psCode) {
    const mainDiv = document.createElement("pre");
    mainDiv.innerHTML = `
        <body>
            ${psCode}
        </body>
    `;
    document.body.appendChild(mainDiv);
}