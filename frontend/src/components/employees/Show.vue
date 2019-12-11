<template>
  <div>
    <md-card>
      <md-card-header>
        <div class="md-title">{{ employee.name }}</div>
      </md-card-header>

      <md-card-content>
        <p><span class="bold">Salary: </span>{{employee.salary}}</p>
        <p><span class="bold">Position: </span>{{employee.position_id}}</p>
      </md-card-content>

      <md-card-actions>
        <router-link :to="{name: 'employee_edit', params: {id: employee.id }}">
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
        employee: {}
      }
    },
    mounted: function() {
      this.$store.dispatch('get_employee_by_id', this.$route.params.id)
       .then((response) => this.employee = response.data)
       .catch(err => { console.log(err); })
    }
  }
</script>