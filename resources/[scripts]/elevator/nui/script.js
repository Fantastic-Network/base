activatedNui = null

document.addEventListener("DOMContentLoaded", function(event) {
    window.addEventListener("message", function(event) {
        var item = event.data;
        const elemento = document.querySelector(`.${item.nuiName}Body`)
        const confirmation = document.querySelector(`.${item.nuiName}ConfirmarCompra`)

        switch (item.action) {
            case "showNui":
                activatedNui = item.nuiName
                listarNuiItens(item.nuiName)
                elemento.classList.remove('showNui')
            break;

            case "hideNui":
                elemento.classList.add('showNui')
                if (confirmation != null) {
                    confirmation.classList.add(`${item.nuiName}DisplaySet`)
                }
            break; 
        }
        document.onkeyup = function(data) {
            if(data.key === 'Escape') {
                if (item.nuiName != 'login')
                    fetch("http://elevator/hideNui", { method:'POST', body:JSON.stringify({ nuiName : item.nuiName }) })
            }
        };
    })
});


async function listarNuiItens(nuiName) {
    switch(nuiName) {
        // ELEVATOR
        case "elevator":
            const elevatorResposta = await fetch("http://elevator/elevatorListButtons")
            const elevatorInformacoes = await elevatorResposta.json()
            let elevatorLista = ''
            const elevatorButtonsList = document.querySelector('#elevatorList')
            elevatorInformacoes.elevatorTable.forEach((item, index) => {
                elevatorLista += 
                `
                    <li>
                        <div class="elevatorButtonStyle" data-index="${item.name}" onclick="elevatorConfirmButton(event)">
                            <span class="spanDiv">${item.name}</span>
                            <div class="ledContainer"></div>
                        </div>
					</li>
                `
            })        
            elevatorButtonsList.innerHTML = elevatorLista
        break;
    } 
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
// FUNCTIONS 
////////////////////////////////////////////////////////////////////////////////////////////////////////

// ELEVATOR

function elevatorConfirmButton(event) {
    const elevatorButtonIndex = event.target.getAttribute("data-index")
    fetch(`https://${GetParentResourceName()}/elevatorButtonActive`, { method:'POST', body:JSON.stringify({"index" : elevatorButtonIndex}) })
    fetch("http://elevator/hideNui", { method:'POST', body:JSON.stringify({ nuiName : activatedNui }) })

}
