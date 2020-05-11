# NYU-CS-GY-6613-proj3

# Full Project Report

Please see [AI Project 3 Report](https://github.com/HaoranZhuExplorer/NYU-CS-GY-6613-proj3/blob/master/AI%20project%203%20Report.pdf)

# Summary

We followed the idea from *[Semantic Code Search](https://arxiv.org/pdf/1909.09436.pdf)*. In this project we focused only on Python language, and reproduced all 5 models [referred on github](https://github.com/github/CodeSearchNet): Neural-Bag-Of-Words, RNN, 1D-CNN, Self-Attention (BERT), and a 1D-CNN+Self-Attention Hybrid.

To further improve the performance over the Elastic Search baseline, we developed our own model by loading the latest pretrained [BERT-Tiny](https://github.com/google-research/bert) parameters into the transformer. Our experiments can be found on [wandb](https://app.wandb.ai/liqi0816/CodeSearchNet?workspace=user-liqi0816) and have been submitted to a community [benchmark](https://app.wandb.ai/github/CodeSearchNet/benchmark).
