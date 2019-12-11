<template>
  <div id="app" class="columns">
    <div class="column">
      <!-- <employee-component v-for="employee in employees" :employee="employee"/> -->
      <ul>
         <li v-for="position in positions" v-bind:key="position">{{ position.name }}</li>
      </ul>
    </div>
  </div>
</template>


<script>
  export default {
    data(){
      return {
        positions: []
      }
    },
    methods: {},
    mounted: function() {
      this.$store.dispatch('get_positions')
       .then((response) => this.positions = response.data)
       .catch(err => { console.log(err); })
    }
  }
</script>