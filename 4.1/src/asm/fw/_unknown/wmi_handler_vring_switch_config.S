/* wmi_handler_vring_switch_config @ 0x8e222c, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_if__alloc_mbox_slot, basic_if__post_event
 */
	.section .text.wmi_handler_vring_switch_config,"ax",@progbits
	.global wmi_handler_vring_switch_config
wmi_handler_vring_switch_config:
	.global L_8e222c
L_8e222c:
	push_s blink
L_8e222e:
	bl L_8c02c4
L_8e2232:
	mov_s r13,r0
L_8e2234:
	ld_s r0,[r1]
L_8e2236:
	mov_s r14,r2
L_8e2238:
	brne_s r0,0,L_8e223c
L_8e223a:
	ld_s r0,[gp,-0xfc]
	.global L_8e223c
L_8e223c:
	st.as r0,[gp,-0x3f]
L_8e2240:
	ld_s r0,[r1,0x4]
L_8e2242:
	brne_s r0,0,L_8e2246
L_8e2244:
	ld_s r0,[gp,-0x100]
	.global L_8e2246
L_8e2246:
	st.as r0,[gp,-0x40]
L_8e224a:
	bl.d L_8c2c38
L_8e224e:
	mov_s r0,r13
L_8e2250:
	mov_s r1,r0
L_8e2252:
	mov_s r2,0x0
L_8e2254:
	stb_s r2,[r0]
L_8e2256:
	mov_s r0,r13
L_8e2258:
	mov_s r3,0x1868
L_8e225e:
	mov r4,0x4
L_8e2262:
	mov_s r5,r14
L_8e2264:
	mov_s r6,r2
L_8e2266:
	bl.d L_8e0460
L_8e226a:
	mov_s r7,r2
L_8e226c:
	b L_8c0334
