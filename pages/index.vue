<template>
  <div class="wrapper">
    <header>
      <h1>anci Temporal Topic Plotter</h1>
      <h2>Quantitative Data Visualisation of term usage in the Geoenergeering mailing list</h2>
      <p>This tool is a result of the <a href="https://interface.fh-potsdam.de/anci/">anci</a> hackathon, which took place 10–11.9 at the <a href="https://www.fh-potsdam.de/">Potsdam University of Applied Sciences</a>. The tool visualises the cumulative frequency of nouns that members use in the public <a href="https://groups.google.com/forum/#!forum/geoengineering">geoengineering mailing list</a> in the time between 26.10.2017 and 9.9.2019.</p>
      <h3>Intention</h3>
      <p>The visualisation is one graphical result of the quantitative analysis of the dataset. It should help to spot patterns in the discussion of certain topics. We use the frequency of nouns as indicators for trends.</p>
      <h3>Data collection</h3>
      <p>We exported the 1823 emails from Apple Mail in the mbox format. From there we used the open-source script <a href="https://github.com/brysonian/mbox-to-json">mbox-to-json</a> by <a href="https://github.com/brysonian">Chandler McWilliams</a> to convert it to a JSON file.<br />In the next step, we wrote a Ruby script to extract the relevant mail content. That includes the sender’s address, the date, the subject and of course the text. The goal was to extract only the relevant text. This excludes old, quoted emails, signatures and information for unsubscribing. This was difficult and is most likely not done exhaustively and infallibly. This has several reasons: Most emails were written in HTML that is formatted differently by every mail program and not done properly. For example, signatures do not have a specific class and quotes are not always wrapped in block quote tags. Another reason is that people composite mails differently. Some people quote inline, some people above or below the previous text.<br />During this step, we also extracted all <a href="https://geoengineering-anci.netlify.com/data/links-with-base.csv">links</a> and images from the mails. We exported these two lists and the list of mails as CSV files.<br />In the next step, we used the open-source script <a href="https://github.com/yohasebe/engtagger">engtagger</a> by <a href="https://github.com/yohasebe">Yoichiro Hasebe</a> to extract the nouns. This, again, is a source of error as the list of extracted nouns already shows some false results. The used script is also not able to categorise »technology« and »technologies« as the same word. This will be fixed later in the interface. In this step, we created a list of <a href="https://geoengineering-anci.netlify.com/data/most-used-words.csv">most used words</a> and a list of <a href="https://geoengineering-anci.netlify.com/data/words_by_month.json">word frequency by month</a>.</p>
      <h3>Data analysis</h3>
      <p>By manually analysing the <a href="https://geoengineering-anci.netlify.com/data/most-active-users.csv">list of authors</a>, we could already find out that the dataset is biased. Out of the 1822 mails in total 727 were written by one author.<br />The analysis of the links gives a good overview of the referenced material. Websites like tandfonline.com, nature.com, scholar.google.com, wiley.com and springer.com are mostly linked to.</p>
      <h3>Data visualisation</h3>
      <p>In the next step, we build a microsite with <a href="https://github.com/vuejs/vue">Vue</a> (<a href="https://github.com/nuxt/nuxt.js">Nuxt</a>) and <a href="https://github.com/d3/d3">D3</a>. In the interactive visualisation, the user can select one or more nouns that are then plotted over time. The line chart shows the cumulative frequency of each word. The user can also combine multiple nouns to one chart so that »technologies« and »technology« are counted as one. Besides, the visualisation and the input filed the interface holds buttons with suggestions and the 50 most used nouns.</p>
    </header>
    <Visualisation />
    <Options />
    <footer>
      <p>Website by <a href="https://jonasparnow.com">Jonas Parnow</a>. Source code on <a href="https://github.com/z3to/geoengineering">Github</a>. MIT Licence</p>
    </footer>
  </div>
</template>

<script>
  import { mapActions } from 'vuex'
  import Visualisation from '~/components/Visualisation.vue'
  import Options from '~/components/Options.vue'

  export default {
    methods: {
      ...mapActions([
        'loadData'
      ])
    },
    components: {
      Visualisation,
      Options
    },
    created () {
      console.log('Load data in index')
      this.loadData()
    }
  }
</script>

<style lang="scss" scoped>
  @import "~@/assets/style/global";

  .wrapper {
  	text-align: center;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;

    header, footer {
      text-align: left;
      width: 60vw;
      max-width: 700px;
      margin-bottom: $spacing * 2;
      margin-top: $spacing;
    }

    footer {
      margin-top: $spacing * 2;
      max-width: 1200px;
      text-align: center;
    }
  }
</style>
