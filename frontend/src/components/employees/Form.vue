<template>
  <form @submit.prevent="submit" class="form">
    <label>Name</label>
    <input required v-model="name" type="text" placeholder="Name"/>
    <label>Salary</label>
    <CurrencyInput v-model="salary" class="demo__currency-input"/>
    <label>Position</label>
    <input type="number" v-model="position_id"/>
    <hr/>
    <button type="submit">Create</button>
  </form>
</template>

<script>
  export default {
    data(){
      return {
        name: "",
        salary: 0,
        position_id: 0
      }
    },
    methods: {
      submit: function () {
        let employee = {
          name: this.name,
          salary: this.salary,
          position_id: this.position_id,
        }
        this.$parent.submit(employee)
       .then(() => this.$router.push('/'))
       .catch(err => console.log(err))
      }
    }
  }
</script>