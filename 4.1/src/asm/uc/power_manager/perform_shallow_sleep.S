/* perform_shallow_sleep @ 0x92af4c, 592 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   perform_shallow_sleep(ENTER) m_last_shallow_sleep_sob: %x, sleep_cycle: %x, tsf:0x%x
 *   perform_shallow_sleep(EXIT) m_last_shallow_sleep_sob: %x, tsf: %x
 *   power_manager.cpp
 * Зовут его: bi_dti__sleep_and_resume, l1_bi_trigger_step, perform_bti_pm_cfg, power_manager__decide_shallow_sleep, rx_funcs__set_rx_off, shallow_sleep_step, tail_perform_shallow_sleep, ucode_cmd__discovery_mode_cfg, ucode_cmd__rx_on
 * Зовёт сам: shallow_sleep_rfc_step, uc_read_tsf64, uc_read_tsf_lo, uc_send_evt__ps_shallow_sleep_ntf, uc_sysassert, uc_tsf_elapsed
 * Глобалы (через gp): 0x800544
 */
	.section .text.perform_shallow_sleep,"ax",@progbits
	.global perform_shallow_sleep
perform_shallow_sleep:
	.global L_92af4c
L_92af4c:
	st.a r13,[sp,-0x18]
L_92af50:
	st blink,[sp, 0x4]
L_92af54:
	st_s r14,[sp,0x8]
L_92af56:
	st_s r15,[sp,0xc]
L_92af58:
	st r16,[sp, 0x10]
L_92af5c:
	st r17,[sp, 0x14]
L_92af60:
	sub_s sp,sp,0xc
L_92af62:
	mov_s r13,r0
L_92af64:
	ld.as r5,[gp,-0x22]
L_92af68:
	mov r17,r4
L_92af6c:
	cmp r5,0x0
L_92af70:
	mov r16,r3
L_92af74:
	bne.d L_92b180
L_92af78:
	mov_s r15,0x0
L_92af7a:
	ld r4,[r13, 0x20]
L_92af7e:
	cmp r4,0x0
L_92af82:
	beq L_92b180
L_92af86:
	ld.as r3,[gp,0x7]
L_92af8a:
	cmp_s r3,0x0
L_92af8c:
	bne L_92b180
L_92af90:
	cmp_s r1,0x0
L_92af92:
	beq_s L_92b080
L_92af94:
	ld_s r0,[r13,0x18]
L_92af96:
	cmp_s r0,0x0
L_92af98:
	bne_s L_92b080
L_92af9a:
	ld_s r0,[r13,0x14]
L_92af9c:
	breq r0,0x0,L_92afac
L_92afa0:
	bl L_924568
L_92afa4:
	ld_s r1,[r13,0xc]
L_92afa6:
	st_s r0,[r13,0x4]
L_92afa8:
	add_s r0,r0,r1
L_92afaa:
	st_s r0,[r13,0xc]
	.global L_92afac
L_92afac:
	mov r11,0x1
L_92afb0:
	st r11,[r13, 0x18]
L_92afb4:
	mov r0,r11
L_92afb8:
	bl.d L_9219c8
L_92afbc:
	mov r1,r16
L_92afc0:
	bl L_9315e8
L_92afc4:
	ldw_s r2,[r13,0x28]
L_92afc6:
	st_s r0,[r13,0x10]
L_92afc8:
	cmp_s r2,0x1
L_92afca:
	mov_s r3,0x1
L_92afcc:
	sub.le r3,r3,r3
L_92afd0:
	st_s r3,[r13,0x1c]
L_92afd2:
	mov r4,0x80209c
L_92afda:
	ldb r8,[r4, 0x4]
L_92afde:
	mov r10,0x1002ce4
L_92afe6:
	bbit0 r8,0x2,L_92b044
L_92afea:
	ld r11,[r4]
L_92afee:
	mov_s r1,0x8020b0
L_92aff4:
	add r5,r11,0x3
L_92aff8:
	extb r5,r5
L_92affc:
	add2 r5,r1,r5
L_92b000:
	st r0,[r5]
L_92b004:
	add r9,r11,0x2
L_92b008:
	extb r9,r9
L_92b00c:
	add2 r9,r1,r9
L_92b010:
	st r2,[r9]
L_92b014:
	add r5,r11,0x1
L_92b018:
	extb r5,r5
L_92b01c:
	add2 r5,r1,r5
L_92b020:
	st r3,[r5]
L_92b024:
	bmsk r10,r10,0x13
L_92b028:
	or r10,r10,0xae000000
L_92b030:
	extb r2,r11
L_92b034:
	add2 r1,r1,r2
L_92b038:
	st r10,[r1]
L_92b03c:
	add r11,r11,0x4
L_92b040:
	st r11,[r4]
	.global L_92b044
L_92b044:
	bl.d L_930cb0
L_92b048:
	add_s r0,gp,0xbc
L_92b04a:
	breq r17,0x0,L_92b078
L_92b04e:
	mov r4,0x1
L_92b052:
	stb r4,[sp, 0x1]
L_92b056:
	stb_s r15,[sp,0x0]
L_92b058:
	add r1,r13,0x200
L_92b060:
	ld r1,[r1, -0xb0]
L_92b064:
	ld.as r4,[r13,0x55]
L_92b068:
	st r1,[sp, 0x4]
L_92b06c:
	st r4,[sp, 0x8]
L_92b070:
	bl.d L_925d28
L_92b074:
	mov r0,sp
	.global L_92b078
L_92b078:
	b.d L_92b180
L_92b07c:
	mov r15,0x1
	.global L_92b080
L_92b080:
	cmp_s r1,0x0
L_92b082:
	bne_s L_92b180
L_92b084:
	ld_s r3,[r13,0x18]
L_92b086:
	cmp_s r3,0x1
L_92b088:
	bne_s L_92b180
L_92b08a:
	breq_s r2,0,L_92b0b4
L_92b08c:
	bl.d L_924568
L_92b090:
	ld r0,[r13, 0x10]
L_92b094:
	ld r9,[r13, 0x8]
L_92b098:
	ld r10,[r13, 0x1c]
L_92b09c:
	add r9,r9,r0
L_92b0a0:
	st r0,[r13]
L_92b0a4:
	brne.d r10,0x0,L_92b160
L_92b0a8:
	st r9,[r13, 0x8]
L_92b0ac:
	brhs r0,0x1d4c0,L_92b14c
	.global L_92b0b4
L_92b0b4:
	mov_s r14,0x0
L_92b0b6:
	st_s r14,[r13,0x18]
L_92b0b8:
	mov r0,r14
L_92b0bc:
	bl.d L_9219c8
L_92b0c0:
	mov r1,r16
L_92b0c4:
	breq r17,0x0,L_92b0dc
L_92b0c8:
	stb r14,[sp, 0x1]
L_92b0cc:
	stb_s r15,[sp,0x0]
L_92b0ce:
	st_s r14,[sp,0x4]
L_92b0d0:
	st r14,[sp, 0x8]
L_92b0d4:
	bl.d L_925d28
L_92b0d8:
	mov r0,sp
	.global L_92b0dc
L_92b0dc:
	bl L_9315e8
L_92b0e0:
	st_s r0,[r13,0x14]
L_92b0e2:
	mov_s r3,0x80209c
L_92b0e8:
	ldb r1,[r3, 0x4]
L_92b0ec:
	mov r11,0x1002d3c
L_92b0f4:
	bbit0.d r1,0x2,L_92b078
L_92b0f8:
	ld r5,[r13, 0x1c]
L_92b0fc:
	ld r8,[r3]
L_92b100:
	mov r2,0x8020b0
L_92b108:
	add r4,r8,0x2
L_92b10c:
	extb r4,r4
L_92b110:
	add2 r4,r2,r4
L_92b114:
	st r0,[r4]
L_92b118:
	add r6,r8,0x1
L_92b11c:
	extb r6,r6
L_92b120:
	add2 r6,r2,r6
L_92b124:
	st r5,[r6]
L_92b128:
	bmsk r11,r11,0x13
L_92b12c:
	or r11,r11,0xaa000000
L_92b134:
	extb r7,r8
L_92b138:
	add2 r2,r2,r7
L_92b13c:
	st r11,[r2]
L_92b140:
	add r8,r8,0x3
L_92b144:
	b.d L_92b078
L_92b148:
	st r8,[r3]
	.global L_92b14c
L_92b14c:
	mov_s r0,blink
L_92b14e:
	mov_s r2,0x1002cd0
L_92b154:
	mov r1,0xa5
L_92b158:
	b.d L_92b178
L_92b15c:
	mov r3,0x145
	.global L_92b160
L_92b160:
	brlo r0,0x6b6c0,L_92b0b4
L_92b168:
	mov_s r0,blink
L_92b16a:
	mov_s r2,0x1002cd0
L_92b170:
	mov r1,0xa7
L_92b174:
	mov r3,0x148
	.global L_92b178
L_92b178:
	bl L_925548
L_92b17c:
	b L_92b0b4
	.global L_92b180
L_92b180:
	mov_s r0,r15
L_92b182:
	add_s sp,sp,0xc
L_92b184:
	ld blink,[sp, 0x4]
L_92b188:
	ld_s r14,[sp,0x8]
L_92b18a:
	ld_s r15,[sp,0xc]
L_92b18c:
	ld r16,[sp, 0x10]
L_92b190:
	ld r17,[sp, 0x14]
L_92b194:
	j.d [blink]
L_92b198:
	ld.ab r13,[sp,0x18]
