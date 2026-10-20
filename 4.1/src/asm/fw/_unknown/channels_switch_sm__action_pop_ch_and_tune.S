/* channels_switch_sm__action_pop_ch_and_tune @ 0x8e9008, 236 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   channels_switch_sm::action_pop_ch_and_tune()
 *   channels_switch_sm::action_pop_ch_and_tune() Stop SCAN RM LOCK WD if running
 *   channels_switch_sm::action_pop_ch_and_tune() Scanning channel #%d completed
 *   channels_switch_sm::action_pop_ch_and_tune() No more channels to scan.
 *   channels_switch_sm::action_pop_ch_and_tune() Scan channel #%d start
 *   channels_switch_sm::action_pop_ch_and_tune() No need to switch- working channel #%d
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_log__emit0, fw_log__emit1, get_g_800140_8c9f8c, llist__pop_front, radio_vtbl__call_tune, tail_mem_pool__free, u_schd__cancel
 */
	.section .text.channels_switch_sm__action_pop_ch_and_tune,"ax",@progbits
	.global channels_switch_sm__action_pop_ch_and_tune
channels_switch_sm__action_pop_ch_and_tune:
L_8e9008:
	push_s blink
L_8e900a:
	push_s r13
L_8e900c:
	sub_s sp,sp,0x4
L_8e900e:
	mov_s r13,r0
L_8e9010:
	mov_s r2,0x1014180
L_8e9016:
	mov_s r0,0x9
L_8e9018:
	bl.d L_8edfb0
L_8e901c:
	mov_s r1,0x2
L_8e901e:
	ld_s r0,[r13,0x34]
L_8e9020:
	breq_s r0,0,L_8e9038
L_8e9022:
	bl L_8c7794
L_8e9026:
	mov_s r0,0x0
L_8e9028:
	st_s r0,[r13,0x34]
L_8e902a:
	mov_s r2,0x10141b0
L_8e9030:
	mov_s r0,0x9
L_8e9032:
	bl.d L_8edfb0
L_8e9036:
	mov_s r1,0x2
	.global L_8e9038
L_8e9038:
	ld_s r3,[r13,0x40]
L_8e903a:
	breq_s r3,0,L_8e9058
L_8e903c:
	mov_s r2,0x1014200
L_8e9042:
	mov_s r0,0x9
L_8e9044:
	mov_s r1,0x2
L_8e9046:
	bl.d L_8edfcc
L_8e904a:
	ld_s r3,[r3,0x8]
L_8e904c:
	ld_s r0,[r13,0x2c]
L_8e904e:
	bl.d L_8ebb7c
L_8e9052:
	ld_s r1,[r13,0x40]
L_8e9054:
	mov_s r0,0x0
L_8e9056:
	st_s r0,[r13,0x40]
	.global L_8e9058
L_8e9058:
	ld_s r0,[r13,0x2c]
L_8e905a:
	ld_s r0,[r0,0x18]
L_8e905c:
	cmp_s r0,0x0
L_8e905e:
	mov_s r0,0x1
L_8e9060:
	sub_s.ne r0,r0,r0
L_8e9062:
	extb.f 0x0,r0
L_8e9066:
	beq_s L_8e9084
L_8e9068:
	mov_s r2,0x101424c
L_8e906e:
	mov_s r0,0x9
L_8e9070:
	bl.d L_8edfb0
L_8e9074:
	mov_s r1,0x2
L_8e9076:
	mov_s r0,r13
L_8e9078:
	mov_s r1,0x6
L_8e907a:
	mov_s r2,0x1
L_8e907c:
	mov_s r3,0x0
L_8e907e:
	mov r4,0x0
L_8e9082:
	b_s L_8e90ec
	.global L_8e9084
L_8e9084:
	bl.d L_8c9f8c
L_8e9088:
	mov_s r0,sp
L_8e908a:
	ld_s r0,[r13,0x2c]
L_8e908c:
	bl.d L_8de2d4
L_8e9090:
	add_s r0,r0,0x18
L_8e9092:
	st_s r0,[r13,0x40]
L_8e9094:
	mov_s r2,0x1014294
L_8e909a:
	ld_s r3,[r0,0x8]
L_8e909c:
	mov_s r0,0x9
L_8e909e:
	bl.d L_8edfcc
L_8e90a2:
	mov_s r1,0x2
L_8e90a4:
	ld_s r1,[r13,0x40]
L_8e90a6:
	mov_s r0,0x805d98
L_8e90ac:
	ld_s r2,[r1,0x8]
L_8e90ae:
	stw_s r2,[r0]
L_8e90b0:
	ld r4,[r1, 0x8]
L_8e90b4:
	ld_s r0,[sp,0x0]
L_8e90b6:
	breq r0,r4,L_8e90d2
L_8e90ba:
	ld_s r0,[r13,0x44]
L_8e90bc:
	mov_s r1,r13
L_8e90be:
	ldb r5,[r0, 0x10]
L_8e90c2:
	mov_s r0,0x2a184
L_8e90c8:
	ld_s r2,[r13,0x30]
L_8e90ca:
	bl.d L_8e0274
L_8e90ce:
	mov_s r3,0x1
L_8e90d0:
	b_s L_8e90f0
	.global L_8e90d2
L_8e90d2:
	mov_s r2,0x10142d8
L_8e90d8:
	mov_s r0,0x9
L_8e90da:
	mov_s r1,0x2
L_8e90dc:
	bl.d L_8edfcc
L_8e90e0:
	mov_s r3,r4
L_8e90e2:
	mov_s r0,r13
L_8e90e4:
	mov_s r1,0x2
L_8e90e6:
	mov_s r2,0x0
L_8e90e8:
	mov_s r3,r2
L_8e90ea:
	mov_s r4,r2
	.global L_8e90ec
L_8e90ec:
	bl L_8d6a1c
	.global L_8e90f0
L_8e90f0:
	b.d L_8c033c
