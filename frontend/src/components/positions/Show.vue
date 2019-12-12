<template>
  <div>
    <md-card class="show">
      <md-card-header>
        <div class="md-title">{{ position.name }}</div>
      </md-card-header>

      <md-card-actions>
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
        position: {}
      }
    },
    mounted: function() {
      this.$store.dispatch('get_position_by_id', this.$route.params.id)
       .then((response) => this.position = response.data)
       .catch(err => { console.log(err); })
    }
  }
</script>