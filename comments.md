# some general comments on coding

1. I just opened these do files and I have no idea what it does.
Okay sure the header has a `description` but that's it. It still falls short of what 
can be achieved with a few clever tricks.
2. Be purposeful with comments: Dont write `what` but rather `why`. `What` is generally much clearer from the code, `why` not so much.
3. A single code file with 692 lines is generally a bad idea. You already have some sections in your code, why not use them to split this monster into several step by step code files?
4. Think in terms of pipeline.
  1. If and when your code fails, you have to debug your whole code file and not to mention running the whole analysis again--its bad.
  2. Present code file does a bunch of sequential analysis on a data set. We do the same but we create a number of meaningful stop-points.
  3. A Pipeline carries out a number of analysis at once on an `input` file and spits out the `output` as an `input` for the next step.
  4. This helps catch error much quickly because an error halts the pipeline. Which is much more informative than a single code file failing.
5. Check this one out: [Pipeline example](https://github.com/azadecon/cinema-sentiment-lab)