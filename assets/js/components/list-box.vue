<template>
  <div class="box">
    <div class="box-header">
      <h3>{{ title }}</h3>
    </div>
    <div class="box-content__list">
      <ul>
        <li v-for="item in list" class="box-content__list-item">
          <router-link :to="buildPath(item)" class="box-content__list-item__link" >
            <span class="box-content__list-item__label">
              {{ item.label }}
            </span>

            <i class="material-icons">
              chevron_right
            </i>
          </router-link>
        </li>
      </ul>
    </div>
  </div>
</template>
<script>
export default {
  props: {
    title: {
      type: String,
      required: true,
    },
    list: {
      type: Array,
      required: true,
    }
  },
  methods: {
    buildPath(item) {
      return { name: item.pathName, params: item.pathParams };
    }
  }
};
</script>
