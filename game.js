let startGame = document.querySelector('.control-buttons span');

startGame.onclick = function () {
    
    let yourName = prompt("what's your Name ?");

    if(yourName == null || yourName == ""){
        document.querySelector('.info-container #name').innerHTML += " Unknown"
    } else{
        document.querySelector('.info-container #name').innerHTML += yourName;
    }

    document.querySelector('.control-buttons').remove();

};

let duration = 1000; // 1 sec

let blocksContainer = document.querySelector('.game-block');

let blocks = Array.from(blocksContainer.children);

let orderRange = [...Array(blocks.length).keys()]; // Array(6) => 6 elements => .keys() => 0,1,...5
// OR orderRange = Array.from(Array(blocks.length).keys());
// orderRange = [0,1,2,3,4,5];

shuffle(orderRange);

// Add Order Css Property to Blocks
blocks.forEach((block, index) => {
    
    // index = 0,1,2,3,4,5
    block.style.order = orderRange[index];

    block.addEventListener('click', function (){

        flipBlock(block);
    });

    document.querySelector('.proper button').onclick = function()
    {
        document.querySelector('.proper').style.display = 'none';
    
        start(blocks);
    }
});

// start game
function start(blocks){

    setTimeout(function(){
        blocks.forEach((block)=>{
            block.classList.remove('has-match');
    
            location.reload();
        });
    }, duration);
}

// Flip Block function
function flipBlock(selectedBlock){

    // add class flipped
    selectedBlock.classList.add('is-flipped');

    let allFlippedBlocks = blocks.filter((flippedBlock) => flippedBlock.classList.contains('is-flipped'));

    if(allFlippedBlocks.length === 2){

        // stop clicking function
        stopClicking(); // يعني متقدرش تدوس تاني مادام فيه اتنين مفتوحين

        // check images
        checkMatched(allFlippedBlocks[0], allFlippedBlocks[1]);
    }

}

// stop click
function stopClicking(){

    // add class no clicking on main container
    blocksContainer.classList.add('no-clicking');

    setTimeout(()=>{

        // remove class no-clicking after duration
        blocksContainer.classList.remove('no-clicking');

    }, duration);
}

// check box
function checkMatched(firstBlock, secondBlock){

    let tries = document.querySelector('.info-container .trail span');

    if(firstBlock.dataset.technology === secondBlock.dataset.technology){

        firstBlock.classList.remove('is-flipped');
        secondBlock.classList.remove('is-flipped');

        firstBlock.classList.add('has-match');
        secondBlock.classList.add('has-match');

        document.getElementById('success').play();
    } else {

        tries.innerHTML = parseInt(tries.innerHTML) + 1;
        
        setTimeout(() => {
            firstBlock.classList.remove('is-flipped');
            secondBlock.classList.remove('is-flipped');
        }, duration);

        document.getElementById('failed').play();
    }
    
    youAreSuccessed(blocks);
};

// if all blocks matched you are successed ^^
function youAreSuccessed(blocks){
    
    let allblocks = blocks.filter((flippedBlock) => flippedBlock.classList.contains('has-match'));

    if(allblocks.length == orderRange.length){
        document.querySelector('.proper').style.display = 'block'
    }
};

// shuffle Array
function shuffle(array){

    let current = array.length,
        temp,
        random;

    while (current > 0){ // array has elements
        
        // Get random Number
        random = Math.floor(Math.random() * current);
        
        // Decrease Length by one
        current-- ;

        // [1] save current element in the stash
        temp = array[current]; // temp = last element in array

        // [2] current element = random element
        array[current] = array[random];

        // [3] random element = get element from stash(temp)
        array[random] = temp;
    }    
    return array;
};