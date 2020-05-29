 <template>
    <div class="About">
        <div class="print_box">
        <div class="input_some">
            <span>输入标题：</span><input
            style       = "width:300px;"
            type        = "text"
            v-model     = "objectData.textTitle"
            placeholder = "请输入标题"
            >
        </div>
        <div class="input_some">
            <span>输入数据描述：</span><input
            style       = "width:300px;"
            type        = "text"
            v-model     = "objectData.nameTitle"
            placeholder = "请输入数据描述,默认为‘数据类型’"
            >
        </div>
        <div class="input_some">
            <div class="text_weight">选择颜色后点击添加按钮</div>
            <span>选择颜色：</span><input
            type        = "color"
            v-model     = "colorData"
            placeholder = "请输入数据描述,默认为‘数据类型’"
            >
            <button @click="addColorClick">addColor</button>
            {{objectData.colorArray}}
        </div>
        <div class="input_some">
            <div class="text_weight">选择颜色后点击添加按钮</div>
            <input
            style       = "width:180px;"
            type        = "text"
            v-model     = "leftData"
            placeholder = "请输入数据"
            >
            <input
            style       = "width:180px;"
            type        = "text"
            v-model     = "rightData"
            placeholder = "请输入数据对应字段"
            >
            <button @click=addDataClick()>addData</button>
            <div>数据为：{{objectData.dataArray}}</div>
            <div>字段为：{{objectData.nameArray}}</div>
        </div>
        <div class="input_some">
            <button @click="clearAll()">清空所有数据</button>
        </div>
        </div>
        <Bar
            class   = "about_bar"
            :get-data = "objectData"
        ></Bar>
    </div>
    </template>

    <script>
    import Bar from "./Bar";
    export default {
    name: "About",
    data() {
        return {
        objectData: {
            textTitle : "",
            nameTitle : "",
            nameArray : [],
            dataArray : [],
            colorArray: []
        },
        leftData : "",
        rightData: "",
        colorData: "#000000"
        };
    },
    components: {
        Bar
    },
    mounted() {},
    methods: {
        addDataClick() {
        this.objectData.dataArray.push(this.leftData);
        this.objectData.nameArray.push(this.rightData);
        },
        addColorClick() {
        this.objectData.colorArray.push(this.colorData);
        },
        clearAll() {
        for (const key in this.objectData) {
            const element = this.objectData[key];
            if (typeof element == "string") {
            this.objectData[key] = "";
            }else if (typeof element == "object") {
            this.objectData[key] = [];
            }
        }
        }
    }
    };
    </script>

    <style scoped>
    .about_bar {
    width : 100%;
    height: 300px;
    }
    .print_box {
    width  : 90%;
    height : 300px;
    padding: 20px;
    }
    .input_some {
    margin-top: 5px;
    border-top: 1px solid #ccc;
    }
    .text_weight {
    font-size  : 22px;
    font-weight: 800;
    }
    </style>