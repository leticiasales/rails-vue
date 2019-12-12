<template>
  <div>
    <md-card v-for="position in positions" v-bind:key="position.id">
      <md-card-header>
        <div class="md-title">{{ position.name }}</div>
      </md-card-header>

      <md-card-actions>
        <router-link :to="{name: 'position_id', params: {id: position.id }}">
          <md-button>View</md-button>
        </router-link>
        <router-link :to="{name: 'position_edit', params: {id: position.id }}">
          <md-button>Edit</md-button>
        </router-link>
      </md-card-actions>
    </md-card>
  </div>
</template>


<script>
  export default {
    data(){
      return {
        positions: []
      }
    },
    mounted: function() {
      this.$store.dispatch('get_positions')
       .then((response) => this.positions = response.data)
       .catch(err => { console.log(err); })
    }
  }
</script>